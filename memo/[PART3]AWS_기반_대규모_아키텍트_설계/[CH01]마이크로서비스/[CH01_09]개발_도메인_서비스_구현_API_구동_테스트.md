## [CH01_09] (개발) 도메인 서비스 구현 - API 구동 테스트

### 구동환경
```bash
docker-compose up
```

### Shop 테스트
```bash
POST http://localhost:8000/api/shop
{
    "shop_name": "pizzaworld",
    "shop_address":"washington dc"
}

GET http://localhost:8000/api/shop


POST http://localhost:8000/api/shop
{
    "shop_name": "pizzaworld",
    "shop_address":"seattle"
}

GET http://localhost:8000/api/shop/1
GET http://localhost:8000/api/shop/2


PUT http://localhost:8000/api/shop/2
{
    "shop_name": "macdonald",
    "shop_address":"seattle"
}

DELETE http://localhost:8000/api/shop/1
```

### Order 테스트
- Order도 동일한 방식으로 테스트 가능
```bash
POST http://localhost:8000/api/order
{
    "shop":"2",
    "address":"portland"
}
```

### CASCADE 설정 테스트
- shop의 pk가 지워지게 되면, 그에 따른 order가 지워지도록 `CASCADE`된 상태
```bash
DELETE http://localhost:8000/api/shop/1
# 이후 관련 order도 같이 제거됨
```