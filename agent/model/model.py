from ultralytics import YOLO
import torch
import numpy as np
import cv2

model = YOLO('C:/BitStoneHackaton/agent/training/runs/detect/train2/weights/best.pt')
device = 'cuda' if torch.cuda.is_available() else 'cpu'
model.to(device)


def run_inference(image_np: np.ndarray):
    results = model(image_np, conf=.07)[0]

    formatted_results = []
    annotated_image = image_np.copy()

    # Iterate detections and draw
    for box in results.boxes:
        x1, y1, x2, y2 = map(int, box.xyxy[0].tolist())
        class_id = int(box.cls[0])
        class_name = model.names[class_id]

        formatted_results.append({
            'x1': x1,
            'y1': y1,
            'x2': x2,
            'y2': y2,
            'class_id': class_id,
            'class_name': class_name
        })

        cv2.rectangle(annotated_image, (x1, y1), (x2, y2), color=(0, 255, 0), thickness=2)
        ((text_width, text_height), _) = cv2.getTextSize(class_name, cv2.FONT_HERSHEY_SIMPLEX, 0.5, 1)
        cv2.rectangle(annotated_image, (x1, y1 - text_height - 4), (x1 + text_width, y1), (0, 255, 0), -1)
        cv2.putText(annotated_image, class_name, (x1, y1 - 2), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1)

    success, buffer = cv2.imencode('.png', annotated_image)
    if not success:
        raise ValueError('Failed to encode image for upload')
    annotated_image = buffer.tobytes()

    return formatted_results, annotated_image
