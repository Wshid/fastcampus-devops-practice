## [CH03_05] kubectl 명령형과 선언형 방식

### 명령형 vs 선언형

#### 명령형(Imperactive)
- 수행하고자 하는 **액션**을 지시
  - e.g. pod 수를 n개로 설정, 버전 설정
- **적은 리소스**에 대해서 빠른 처리 가능
- 여러 명령어를 알아야 함

#### 선언형(Declarative)
- 인프라 관리의 현재 방향
- 도달하고자 하는 상태(**Desired State**)를 선언
- 코드로 관리 가능 -> `GitOps` 활용 가능
  - 변경 사항에 대한 Audit(감사) 용이
  - **코드 리뷰**를 통한 협업
- **멱등성 보장**(`apply`)
- 많은 리소스에 대해서도 `manifest` 관리 방법에 따라 빠르게 처리 가능
- 알아야할 **명령어 수**가 적음
- `yaml` 스펙에 대해서만 공부하면 됨

### 명령형 kubectl 명령어
- `docker run` 명령과 유사
```bash
# ubuntu:focal 이미지로 ubuntu pod 생성
kubectl run -i -t ubuntu --image=ubunt성:focal bash
# grafana deployment object에 대해 NodePort 타입의 Service object 생성(node에 포트 개방)
kubectl expose deployment grafana --type=NodePort --port=80 --target-port=3000
# frontend deployment의 www 컨테이너 이미지를 image:v2로 변경
kubectl set image deployment/frontend www=image:v2
# frontend deployment를 revision 2로 rollback
kubectl rollout undo deployment/fronted --to-revision=2
```

### 선언형 kubectl 명령어
```bash
# deployment.yaml에 정의된 k8s object cluster에 반영
kubectl apply -f deployment.yaml
# deployment.yaml에 정의된 k8s object 제거
kubectl delete -f deployment.yaml
# 현재 디렉터리의 kustomization.yaml 파일을 k8s object clsuter에 반영
kubectl apply -k ./
```

### 실습
- `3-docker-kubernetes/5-k8s-start` 

### 결론
- 명령 사용 추천 방향
- **CRUD**는 선언형 방식(apply)으로 사용
- ssh 접속, 로그 확인, 포트 포워딩 같은 **세부 케이스** 들은 명령형 사용