## [CH02_04] jenkins pipeline 실습2 jenkins 설치

### Jenkins 설치
- package를 직접 설치
- Docker로 설치

### 실습
```bash
ssh bastion

vi ~/.ssh/dev.pem
# dev.pem의 내용을 클립보드로 복사(in MAC)
cat ~/.ssh/dev.pem | pbcopy

ssh -i ~/.ssh/dev.pem ec2-user@{jenkins public ip}

sudo yum install -y git
git clone https://github.com/dev-chulbuji/devops_06_03_jenkins.git
cd src/jenkins_remote_package/

# jenkins 공식 홈페이지 가이드 스크립트와 동일
sh install.sh

# 서비스 잘 떠있는지 확인 1
journalctl -u jenkins.service -f

# 서비스 잘 떠있는지 확인 2
netstat -nlp | grep 8080

# 서비스 잘 떠있는지 확인 3
curl -v http://localhost:8080
```
- load balancer 주소로 로컬에서 접속시 잘 되는지 확인

### 도커 실습
```bash
sudo yum install -y docker
sudo systemctl enable docker
sydo systemctl start docker
sudo systemctl status docker

# 소켓 사용 여부 확인
# docker group에 속해야 dockercli사용 가능
ll /var/run/ | grep docker
usermod -aG docker ec2-user
cat /etc/passwd | grep ec2-user
docker ps -a

## 이후 세션 재접속
docker ps -a

cat /etc/passwd | grep jenkins
ps -ef | grep jenkins

sudo usermod -aG docker jenkins

```