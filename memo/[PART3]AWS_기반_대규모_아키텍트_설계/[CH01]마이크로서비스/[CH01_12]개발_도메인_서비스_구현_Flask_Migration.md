## [CH01_12] (개발) 도메인 서비스 구현 - Flask, Migration
- db 설정 이후 마이그레이션 필요

### Migrate
- manager.py 구성
```bash
docker-compose up
docker-compose exec backend sh
python manager.py db init
python manager.py db migrate
python manager.py db upgrade
```