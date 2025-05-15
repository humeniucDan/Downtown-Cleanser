import os

import cv2
import google.generativeai as genai
import numpy as np
from PIL import Image
import json
import dotenv

import repository.pg_repo

# --- Configuration ---
# Securely load your API key (replace with your actual key or use environment variables)
# For example, using an environment variable:

dotenv.load_dotenv()
API_KEY = os.getenv("GEMINI_API_KEY")
if not API_KEY:
    raise ValueError("Please set the GEMINI_API_KEY environment variable.")

# Configure the Gemini client
genai.configure(api_key=API_KEY)

# --- Prepare the Prompt ---
prompt = """
Analyze the provided image to identify the following urban issues:
issue_id type
         
"""

detection_classes = repository.pg_repo.get_detection_classes()
for detection_class in detection_classes:
    prompt += str(detection_class['id']) + '         ' + detection_class['name'] + '\n'

prompt += """
0.  `issue_id`
1.  `issue_type`: A string describing the type of issue found (e.g., "graffiti", "illegal_parking", "misplaced_garbage").
2.  `description`: A brief text description of the specific issue found.
3.  `bounding_box`: An approximate bounding box for the issue. Represent this as a list of 4 numbers: `[x_min, y_min, x_max, y_max]`. These should be *normalized coordinates*, ranging from 0.0 to 1.0, where (0.0, 0.0) is the top-left corner and (1.0, 1.0) is the bottom-right corner of the image.

Example of a single item in the JSON list:
{
    "issue_id": 1,
    "issue_type": "graffiti",
    "description": "Red spray paint tag on a wall.",
    "bounding_box": [0.25, 0.40, 0.60, 0.75]
}

If no relevant issues are found, return an empty JSON list: `[]`.
Do not include any text before or after the JSON list itself. Just output the JSON.
"""

# --- Select the Model ---
# Use gemini-pro-vision for multimodal input
model = genai.GenerativeModel('models/gemini-2.0-flash') # <-- *** This is the main change ***

def run_inference(image_np: np.ndarray):
    print(prompt)

    annotated_image = image_np.copy()
    img_pil = Image.fromarray(image_np) # Use PIL Image for Gemini
    image_height, image_width = image_np.shape[:2] # Get image dimensions for denormalization

    formatted_results = []
    # class_name_to_id_map = {} # To dynamically assign class IDs
    # next_class_id = 0

    # --- Send Request to Gemini API ---
    print(f"Sending request to Gemini (model: {model.model_name})...")
    try:
        response = model.generate_content(
            [prompt, img_pil], # Pass PIL image
            stream=False
        )
        response.resolve()

    except Exception as e:
        print(f"An error occurred during API call: {e}")
        # Consider raising the exception or returning an empty list/None
        # exit() # Avoid exit() in a function, let the caller decide
        return [] # Return empty list on API error

    # --- Process the Response ---
    print("Received response:")
    try:
        response_text = response.text.strip()
        print("--- Raw Response Text ---")
        print(response_text)
        print("------------------------")

        if response_text.startswith("```json"):
            response_text = response_text[7:]
        if response_text.endswith("```"):
            response_text = response_text[:-3]
        response_text = response_text.strip()

        identified_issues = json.loads(response_text)

        print("\n--- Processing Parsed Issues for Formatted Output ---")
        if isinstance(identified_issues, list) and identified_issues:
            for issue in identified_issues:
                class_id = issue.get('issue_id')
                class_name = issue.get('issue_type')
                description = issue.get('description', 'N/A') # Keep description for potential logging
                normalized_bbox = issue.get('bounding_box')

                if not class_name:
                    print(f"Warning: Skipping issue due to missing 'issue_type': {issue}")
                    continue
                if not normalized_bbox or not (isinstance(normalized_bbox, list) and len(normalized_bbox) == 4):
                    print(f"Warning: Skipping issue '{class_name}' due to missing/invalid 'bounding_box': {normalized_bbox}")
                    continue

                # Denormalize bounding box coordinates
                nx1, ny1, nx2, ny2 = normalized_bbox
                x1 = int(nx1 * image_width)
                y1 = int(ny1 * image_height)
                x2 = int(nx2 * image_width)
                y2 = int(ny2 * image_height)

                # Ensure x1 < x2 and y1 < y2 (optional, but good practice)
                x1, x2 = min(x1, x2), max(x1, x2)
                y1, y2 = min(y1, y2), max(y1, y2)

                # Get or assign class_id
                # if class_name not in class_name_to_id_map:
                #     class_name_to_id_map[class_name] = next_class_id
                #     next_class_id += 1
                # class_id = class_name_to_id_map[class_name]

                formatted_results.append({
                    'x1': x1,
                    'y1': y1,
                    'x2': x2,
                    'y2': y2,
                    'class_id': class_id,
                    'class_name': class_name,
                    'description': description
                })

                cv2.rectangle(annotated_image, (x1, y1), (x2, y2), color=(0, 255, 0), thickness=2)
                ((text_width, text_height), _) = cv2.getTextSize(class_name, cv2.FONT_HERSHEY_SIMPLEX, 0.5, 1)
                cv2.rectangle(annotated_image, (x1, y1 - text_height - 4), (x1 + text_width, y1), (0, 255, 0), -1)
                cv2.putText(annotated_image, class_name, (x1, y1 - 2), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1)
                print(f"  Added: {class_name} (ID: {class_id}) at [{x1},{y1},{x2},{y2}] (Desc: {description})")

        elif isinstance(identified_issues, list) and not identified_issues:
            print("No relevant urban issues identified by the model.")
        else:
            print("Warning: Unexpected response format. Expected a JSON list.")
            print(f"Parsed data: {identified_issues}")

    except json.JSONDecodeError:
        print("\nError: Failed to decode the response as JSON.")
        print("The model might not have followed the JSON format instructions exactly.")
    except AttributeError:
         print("\nError: Could not access response text. Check the API call and response object structure.")
         print(f"Full response object: {response}")
    except Exception as e:
        print(f"\nAn error occurred processing the response: {e}")

    success, buffer = cv2.imencode('.png', annotated_image)
    if not success:
        raise ValueError('Failed to encode image for upload')
    annotated_image = buffer.tobytes()

    return formatted_results, annotated_image