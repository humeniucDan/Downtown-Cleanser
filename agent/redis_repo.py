import asyncio
import redis.asyncio as redis

HOST, PORT = 'localhost', 6379

QUEUE = 'queue'

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

async def main():
    stop_event = asyncio.Event()
    task = asyncio.create_task(listener(stop_event))
    await task


if __name__ == '__main__':
    asyncio.run(main())
