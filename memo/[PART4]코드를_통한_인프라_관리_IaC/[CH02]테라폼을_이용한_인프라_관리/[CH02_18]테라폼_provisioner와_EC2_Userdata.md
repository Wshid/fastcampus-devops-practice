## [CH02_18] 테라폼 Provisioner와 EC2 Userdata
- `2-terraform/16-provisioner-userdata`

### Provisioner
- syntax
- 3가지 기본 provisioner
  - file: local -> remote file 복사
  - local_exec: local pc에서 명령어 수행
  - remote_exec: remote machine에서 명령어 수행
    - SSH: unix/linux
    - winrm: windows
- 첫 리소스 생성 시점에 수행
- 여러 옵션을 주어
  - 삭제 시점이나, 매번 수행

### UserData
- AWS EC2 Userdata
- cloud_init
  - 부팅 시점에 user_data bootstraping
    - 사용자 생성
    - 파일 구성
    - sw 설치
  - linux 차원에서 지원
- UserData
  - AMI 이미지: 첫 부팅 시점에만 진행