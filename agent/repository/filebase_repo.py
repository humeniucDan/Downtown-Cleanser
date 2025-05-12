import io
import os

import cv2
import numpy as np
from dotenv import load_dotenv
import boto3
from botocore.exceptions import ClientError
from PIL import Image

load_dotenv()
AWS_ACCESS_KEY_ID        = os.getenv("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY    = os.getenv("AWS_SECRET_ACCESS_KEY")
AWS_REGION               = os.getenv("AWS_REGION")
S3_BUCKET_NAME           = os.getenv("S3_BUCKET_NAME")
S3_ENDPOINT_URL          = os.getenv("S3_ENDPOINT_URL")
FILEBASE_DEFAULT_GATEWAY = os.getenv("FILEBASE_DEFAULT_GATEWAY")

missing = [name for name,val in {
    "AWS_ACCESS_KEY_ID": AWS_ACCESS_KEY_ID,
    "AWS_SECRET_ACCESS_KEY": AWS_SECRET_ACCESS_KEY,
    "AWS_REGION": AWS_REGION,
    "S3_BUCKET_NAME": S3_BUCKET_NAME}.items() if not val]
if missing:
    raise ValueError(f"Missing env vars: {', '.join(missing)}")  # fail fast

session = boto3.Session(
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
    aws_session_token=None,
    region_name=AWS_REGION
)
s3 = session.client("s3",
        endpoint_url=os.getenv("S3_ENDPOINT_URL"))

def get_object(key: str) -> np.ndarray:
    try:
        resp = s3.get_object(Bucket=S3_BUCKET_NAME, Key=key)
        body = resp["Body"].read()

        io.BytesIO(body)
        image = Image.open(io.BytesIO(body)).convert("RGB")
        image_np_rbg = np.array(image)
        image_np = cv2.cvtColor(image_np_rbg, cv2.COLOR_RGB2BGR)

        return image_np

    except ClientError as err:
        code = err.response["Error"]["Code"]
        msg  = err.response["Error"]["Message"]
        print(f"S3 ClientError [{code}]: {msg}")

def put_object(key: str, content) -> str:
    try:
        rsp = s3.put_object(Bucket=S3_BUCKET_NAME, Key=key, Body=content, ContentType="application/octet-stream")
        cid = rsp['ResponseMetadata']['HTTPHeaders'].get('x-amz-meta-cid')

        print(FILEBASE_DEFAULT_GATEWAY + cid)
        return FILEBASE_DEFAULT_GATEWAY + cid
    except ClientError as err:
        code = err.response["Error"]["Code"]
        msg  = err.response["Error"]["Message"]
        print(f"S3 ClientError [{code}]: {msg}")
