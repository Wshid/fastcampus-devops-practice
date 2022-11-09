## [CH02_10] 도커 컨테이너 다루기 Dockerfile

### Dockerfile 문법
- 공식 docs 활용
- 환경 변수 전달
  ```Dockerfile
  ENV FOO=/bar
  WORKDIR ${FOO}
  ```
- 변수 전달
  - `ARG`보다 `ENV`가 우선순위가 높음
- `3-docker-kubernetes/3-dockerfile/nodejs-server`
- `ADD`는 `COPY`와 유사
  - 지양함
- `USER`
  - docker container가 기본적으로 사용할 사용자 지정