## [CH02_01] DevOps 개요
- DevOps
  - 제품의 변경 사항을 품질을 보장함과 동시에
  - 프로덕션에 반영하는데 걸리는 시간을 단축하기 위한 실천 방법의 모음
- Dev + Ops
  - 개발/운영 조직의 경계를 허물고 통합하고자 함

### DevOps가 필요한 이유
- 소프트웨어 생성 주기(SDLC; Software Development Lifecycle)
  - Design: Architect
  - Develop: Develop
  - Test: SDET
  - Deploy: Release Eng
  - Operate: Sys Admin
  - Support: Customer Support
- 각 단계를 넘어가기 위해 커뮤니케이션이 필요하며
  - 그에 따라 병목이 발생할 수 있음
- DevOps: 위 싸이클을 극복하기 위함
  - 테스트, 배포, 운영단계에 직접 참여
- Full-Cycle Developer
  - Netflix에서 제시한 모델
  - 소프트웨어 개발 생애주기의 전체에 직접 참여하는 개발자

### Devops를 하는 방법
- Devops는 패러다임
- 방법을 제시하지 X
- Devops는 문화
- 목표
  - **개발과 운영의 벽을 허물어 더 빨리 자주 배포하자**
- 6가지 실천 방법
  - **Continuous Integration**
  - **Continuous Devlivery**
    - 이 둘만 진행해도, 어느정도는 운영 가능
  - Micro-services
    - 어느정도 규모가 있는 조직
    - 커다란 서비스를 작게 쪼갬
      - 배포/개발/테스트를 더 빠르게
  - IaC(Infrastructure as Code)
    - 서비스를 배포함에 있어, 인프라에도 변경사항 존재
    - 인프라도 자동화가 필요
  - Monitoring & Logging
    - logging을 중앙에서 확인할 수 있도록
  - Communication & Collaboration
