## [CH02_18] (인프라) 로드밸런서(L4, L7)의 동작원리와 AWS ELB
- 트래픽을 받아 분산을 시켜주는 역할

### L4 load balancing
- classic load balancing(in AWS)
- TCP,UDP layer에서 제어
- 장점
  - 빠르고 쌈, 단순함
- 단점
  - Microservice에 불리함

### L7 load balancing
- 실제 app상의 데이터를 확인하여 balance
- 장점
  - 스마트
  - MS에 유리
- 단점
  - 데이터를 직접 확인하므로, 속도가 상대적으로 느림
  - 비용 이슈