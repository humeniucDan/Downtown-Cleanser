import asyncio
import redis.asyncio as redis

import model.model
from repository import filebase_repo, pg_repo

HOST, PORT = 'localhost', 6379

QUEUE = 'queue'
ACK_QUEUE = 'queue:ack'

client = redis.Redis(host=HOST, port=PORT, db=0)

async def listener(stop_event: asyncio.Event):
    try:
        while not stop_event.is_set():
            result = await client.blpop([QUEUE], timeout=1)
            if result:
                queue_name, raw = result
                await process_message(raw)
    finally:
        await client.aclose()


async def process_message(data: bytes):
    text = data.decode('utf-8')
    print(f'Received text:\n{text}')

    split_text = text.split(':')
    image_id:int =  int(split_text[0])
    filename = split_text[1]

    image = filebase_repo.get_object('raw/' + filename)

    results, annotated_image = model.model.run_inference(image)
    annotated_image_url = filebase_repo.put_object('annotated/'+filename, annotated_image)

    pg_repo.insert_detections_pg(results, image_id)
    pg_repo.update_image_processed(image_id, annotated_image_url)

    await client.publish(ACK_QUEUE, f"{image_id}")

async def main():
    stop_event = asyncio.Event()
    task = asyncio.create_task(listener(stop_event))
    await task


if __name__ == '__main__':
    asyncio.run(main())
