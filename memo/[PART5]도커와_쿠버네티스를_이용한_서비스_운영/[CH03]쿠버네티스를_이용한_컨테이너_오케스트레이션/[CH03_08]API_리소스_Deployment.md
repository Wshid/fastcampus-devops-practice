## [CH03_08] API 리소스 - Deployment

### 디플로이먼트란?
- 파트의 **이미지 버전**이 갱신될 때 **배포 전략**을 설정
- deployment object를 생성하면
  - 대응되는 `ReplicaSet`과 `Pod`를 생성
- 기본적으로 `Recreate` 전략과 `RollingUpdate` 전략 지원
- 사용자는 특수한 목적이 아니라면
  - pod, Replicaset이 아닌 `deployment`로 워크로드 관리

#### 실습
- `3-docker-kubernetes/8-k8s-deployment`
```bash
kubectl apply -f deployment.yaml
kubectl api-resources | grep deployment
kubectl get deploy

# replicasets
kubectl get rs

kubectl get pods
```

### 디플로이먼트의 배포 전략

#### 재생성(Recreate)
- 기존 Replicaset의 pod를 모두 종료 후, 새 리플리카셋의 pod을 새로 생성

#### 롤링 업데이트(Rolling Update)
- 세부 설정에 따라 **기존 리플리카셋**에서 신규 리플리카셋으로 점진적 이동
  - `maxSurge`
    - 업데이트 과정에 `spec.replicas` 수 기준 **최대 새로 추가되는 파드 수**
  - `maxUnavailable`
    - 업데이트 과정에 `spec.replicas` 수 기준 **최대 이용 불가능한 파드 수**
- 예시
  - 새 파드 생성 후 기존 파드 삭제 반복
    - 만들고 지우고
    - **클러스터 노드 자원이 부족해질 수 있음**
    - **트래픽에서 이점**
    ```yaml
    maxSurge: 1
    maxUnavilable: 0 # 이용 불가인 pod가 X
    ```
  - 기존 파드 삭제 후 새 파드 생성 반복
    - 전체가 특정 수(e.g. 10개)를 넘길 수 없음
    - 지우고 만들고
    - **노드 자원이 초과될 수 없음**
    - **트래픽이 많은 상황에서 적은 수로 대응 필요**
    ```yaml
    maxSurge: 0
    maxUnavilable: 1
    ```

#### 실습
- `3-docker-kubernetes/8-k8s-deployment/rolling-update.yaml`
```bash
# --record: 변경 revision을 남김. rolling시의 기록을 history에서 확인할 수 있도록
kubectl apply -f rolling-update.yaml --record
kubectl rollout history deployment rolling

# 하나씩 롤링하여 업데이트
# 만들고 사라지는 형태(최대 6개)
kubectl set image deployment rolling nginx=nginxdemos/hello:latest --record

# 특정 파일 지정, 리비전 확인 가능
kubectl rollout history -f rolling-update.yaml

# rollback
kubectl rollout undo deployment rolling --to-revision=1
# rollout 상태 확인
kubectl rollout status deployment rolling
```