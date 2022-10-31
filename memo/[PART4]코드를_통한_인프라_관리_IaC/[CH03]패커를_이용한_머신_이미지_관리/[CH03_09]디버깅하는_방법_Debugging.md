## [CH03_09] 디버깅하는 방법(Debugging)
- AWS AMI를 만드는 과정이 오래 걸림
  - 한번 provisioning code가 실패한 이후, 재구동하려면 너무 시간 비용이 많이 듦

### 디버깅 방법
- `breakpoint` provisioner를 사용하기
- `packer build -debug .`
  - packer가 실행하는 모든 단계를 사용자의 입력을 받는 형태
  - pem 파일이 신규 생성됨
    - debug build 생성시 임시 pem키를 생성함
    - 해당 키를 가지고 aws instance에 접속 가능
    - provisioning 중간 실패시, aws instance 내의 로그 확인 가능
      ```bash
      cat /var/log/syslog
      cat /var/log/cloud-init-output.log
      ``` 
  - `Ctrl+C`로 빠져나올 수 있음