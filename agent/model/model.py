from ultralytics import YOLO
import torch
import numpy as np

model = YOLO('agent/training/yolo_project/yolov8_custom2/weights/best.pt')
model.to('cuda' if torch.cuda.is_available() else 'cpu')

def run_inference(image_np: np.ndarray):
    results = model(image_np)[0]  # Run inference and get the first result
    formatted_results = []
    

    for box in results.boxes:
        x1, y1, x2, y2 = box.xyxy[0].tolist()
        class_id = int(box.cls[0])
        formatted_results.append({
            'x1': x1,
            'y1': y1,
            'x2': x2,
            'y2': y2,
            'classId': class_id,

        })

    return formatted_results
