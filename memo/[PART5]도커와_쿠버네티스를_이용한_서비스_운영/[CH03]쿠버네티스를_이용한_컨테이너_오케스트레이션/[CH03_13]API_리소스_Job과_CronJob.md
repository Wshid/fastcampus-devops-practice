## [CH03_13] API 리소스 - Job과 CronJob

### Job 이란?
- 특정 동작을 수행하고 종료하는 작업을 정의하기 위한 리소스
- 내부적으로 **파드를 생성**하여 작업 수행
- Pod의 상태가 Running이 아닌 `Completed`가 되는것이 **최종 상태**
- 실패시 재시작 옵션, 작업 수행 횟수, 동시 실행 수 등 세부 옵션 제공

### 크론잡이란?(CronJob)
- 주기적으로 특정 동작을 수행하고 종료하는 작업을 정의하기 위한 리소스
- 리눅스의 Cron 스케줄링 방법을 그대로 사용
- 내부적으로 Job을 생성하여 작업 수행
- 주기적으로 **데이터 백업**하거나 **데이터 점검** 및 **알림 전송**등의 목적으로 사용

### 실습
- `3-docker-kubernetes/13-k8s-job`
```bash
kubectl apply -f job.yaml
# COMPLETIONS로 몇번 시도했고, 얼마나 걸렸는지 확인 가능
kubectl get job

kubect get job hello
kubectl logs job hello

kubectl describe job hello

kubectl get cronjob
# 이름에 random한 postfix가 붙음
kubectl get job
```
- `Deployment -> ReplicaSet -> Pod`의 형태 처럼
  - `CronJob -> Job -> Pod` 형태로 구성