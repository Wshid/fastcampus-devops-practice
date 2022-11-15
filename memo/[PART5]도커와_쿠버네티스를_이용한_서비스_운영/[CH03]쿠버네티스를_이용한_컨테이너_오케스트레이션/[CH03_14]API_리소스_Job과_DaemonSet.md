## [CH03_14] API 리소스 - DaemonSet

### DaemonSet이란?
- 각 노드마다 **꼭 실행되어야 하는 워크로드**가 있다면?
  - e.g. 로그 수집, 메트릭 수집, 네트워크 구성

#### DaemonSet
- 클러스터 상의 모든 노드에 **동일한 파드**를 하나씩 생성
- **로그 수집/메트릭 수집/네트워크 구성**등의 목적으로 많이 사용
  - 로그 수집: `filebeat/fluentbit`
  - 메트릭 수집: `node-exporter/metricbeat/telegraf`
  - 네트워크 구성: `kube-proxy/calico`
- `Deployment`와 마찬가지로 `Label Selector` 기반으로 동작
- `nodeSelector/Affinity/Toleration`등을 통해 실행되어야 할 노드 목록을 **필터링**
  - 특정 노드 그룹에만 띄우는 옵션들(꼭 모든 노드가 아닌)
  - `Pod, Deployment, StatefulSet`등에서도 사용 가능한 옵션
- c.f. Deployment의 경우 Scheduler가 임의 노드에 할당하는 형태

### 실습
- `3-docker-kubernetes/14-k8s-daemonset`
```bash
kubectl apply -f .
kubectl get daemonset
kubectl get node
kubectl get pod

# 각 container log를 가지고 filebeat가 consume
kubectl logs filebeat-npkbr ...
```