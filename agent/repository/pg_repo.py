import os
import psycopg2
from dotenv import load_dotenv
from psycopg2.extras import RealDictCursor

load_dotenv()

def get_pg_connection():
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT")
    )

def get_detection_classes():
    conn = get_pg_connection()
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("SELECT id, name, type FROM detection_class;")
            rows = cur.fetchall()
            return rows
    finally:
        conn.close()


def insert_detections_pg(detections, photo_id):
    conn = get_pg_connection()
    with conn.cursor() as cur:
        for det in detections:
            cur.execute(
                """
                INSERT INTO detections (detection_class_id, image_id, x1, x2, y1, y2, description)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
                """,
                (det['class_id'], photo_id, int(det['x1']), int(det['x2']),
                 int(det['y1']), int(det['y2']), det['description'])
            )
        conn.commit()

def update_image_processed(id: int, annotated_image_url: str):
    conn = get_pg_connection()
    with conn.cursor() as cur:
        query = """
            UPDATE images
            SET is_processed = TRUE,
                processed_at = NOW(),
                annotated_image_url = %s
            WHERE id = %s;
        """
        cur.execute(query, (annotated_image_url, id))
        conn.commit()
