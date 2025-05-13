import asyncio

from service import redis_service

if __name__ == '__main__':
    asyncio.run(redis_service.main())