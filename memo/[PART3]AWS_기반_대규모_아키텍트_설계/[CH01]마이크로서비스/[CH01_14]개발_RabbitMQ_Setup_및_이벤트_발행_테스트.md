## [CH01_14] (개발) RabiitMQ Setup 및 이벤트 발행 테스트
- consumer, producer 수행 방법
```bash
docker-compose up
docker-compose exec backend sh

python consumer.py
# 이후 rest-api 호출:  localhost:8000/api/shop
```