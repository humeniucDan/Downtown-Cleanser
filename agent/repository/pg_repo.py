import os
import psycopg2

def get_pg_connection():
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT")
    )


def insert_detections_pg(detections, photo_id):
    conn = get_pg_connection()
    with conn.cursor() as cur:
        for det in detections:
            cur.execute(
                """
                INSERT INTO detections (class_id, photo_id, x1, x2, y1, y2)
                VALUES (%s, %s, %s, %s, %s, %s)
                """,
                (det['classId'], photo_id, int(det['x1']), int(det['x2']),
                 int(det['y1']), int(det['y2']))
            )
        conn.commit()