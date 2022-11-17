## [CH03_15] API 리소스 - Ingress

### 인그레스란?
- 외부로부터 요청에 대해 TLS 설정 관리, 라우팅 관리
  - Service와 유사
  - Service의 경우 L4 Level
- L7 level이 아닌 **L7 Level**에서 요청 처리

#### Ingress
- 외부 요청을 받아 **L7**에서 어떻게 처리할 것인가
- Routing 기능 수행(Host, Path 단위)
- SSL/TLS 통신 암호화 처리
  - 각 호스트에 대한 인증서 적용
- Gateway 처럼 요청을 받아 처리
- Ingress -> Service -> Pod 순서

### 인그레스 컨트롤러
- k8s 클러스터는 기본적으로 **Ingress API** 리소스를 다루는
  - Ingress Controller 제공 X
- Ingress API 리소스에 대한 스펙만 제공
  - 사용자가 직접 원하는 **Ingress Controller** 설치 필요
    - 이를 제공하는 API 종류가 많기 때문(app에 따라)

#### 대표적인 Ingress Controller
- **NGINX Ingress Controller**
  - minikube에 포함
- Kong Ingress Controller
- **AWS Load Balancer Controller**
- Google Load Balancer Controller

#### Ingress Class
- 하나의 클러스터에서 **여러 Ingress Controller**를 사용할 수 있도록 하기 위해 만들어진 리소스
- `IngressClass = IngressController + Configuration`
- 예시
  - nginx: service A
  - ALB: service C, D, ...

#### Ingress
- 라우팅 규칙 및 TLS 설정 정의
- 하나의 Ingress Class와 연결

### Nginx Ingress Controller
- Nginx 웹서버 기반의 Ingress Controller
- LoadBalancer Service(or NodePort) -> Nginx Controller -> Ingress -> Nginx Service 
  - k8s의 서비스를 두개 이용하는 구조
    - LoadBalancer Service, Nginx Service

### AWS Load Balancer Controller
- Ingress뿐 아니라 여러 기능 수행
- AWS에서 관리하는 **오픈소스 컨트롤러**
  - AWS ALB(Application LoadBalancer) 기반의 Ingress Controller
  - AWS NLB(Network LoadBalancer) 기반의 LoadBalancer 타입 Service

### 실습
- `3-docker-kubernetes/15-k8s-ingress`
```bash
cd grafana
kubectl apply -f grafana/
kubectl apply -f hello/
kubectl apply -f httpd/

minikube addons list
# ingress - disabled
minikube addons enable ingress
kubectl get ns
# ingress-nginx 확인

kubectl get all -n ingress-nginx

kubectl get ingressclass
# nginx 확인

# IngressClass 확인
kubectl get ingressclass nginx -o yaml

kubectl apply -f ingress-path.yaml
kubectl get service -n ingress-nginx
kubectl get node -o wide

# 호스트 변조 테스트
kubectl apply -f ingress-host.yaml
kubectl get ingress
curl http://... -H "Host: hello.fastcampus"
curl http://... -H "Host: grafana.fastcampus"

kubectl apply -f ingress-default.yaml
kubectl get ingress
curl http://... -H "Host: asdf.fastcampus"
```