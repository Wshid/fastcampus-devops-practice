## [CH03_05] 선택적 빌드(only & except)
- 여러 빌드 프로세스 정의는 가능
- 특정 빌드 프로세스만 실행하거나, 제거할때
  - `only, except`를 활용

### 수행 방법
```bash
packer build -only="null.two"
packer build -only="null.two,fastcampus-packer.null.two"

packer build -except="null.two,fastcampus-packer.null.two"

# grok 패턴 사용 가능
packer build -only="*.one" 
```