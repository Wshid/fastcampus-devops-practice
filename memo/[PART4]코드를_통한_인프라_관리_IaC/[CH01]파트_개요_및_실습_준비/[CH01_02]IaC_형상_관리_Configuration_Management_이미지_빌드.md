## [CH01_02] IaC - 형상 관리(Configuration Management) - 이미지 빌드

### IaC(Infrastructure as Code)
- 네트워크, 로드밸런서, 저장소, 서버 등의 **인프라 자원**을
- 수동 설정이 아닌 **코드**를 이용하여 **프로비저닝** 및 **관리**
- 대표적 IaC 도구
  - **Terraform**, CloudFormation, Pulumi, Azure ARM Template

### 형상 관리(Configuration Management)
- **OS상에 필요한 sw를 설치하고 원하는 설정**으로 관리
- Configuration as Code로 불림
- 대표적 형상 관리 도구
  - **Ansible**, Puppet, Chef, Salt Stack

### IaC vs 형상 관리
- https://www.linkedin.com/pulse/qa-configuration-management-tools-vs-infrastructure-code-jenkins
- 각 도구들이 개선되면서 겹치는 요소가 많아짐
  - Infrastructure Templating
  - Manage Infrastructure
  - Install applications and one time configurations
  - Deploy configuration and changes post install
- 단, 도구별 핵심 기능이 있기 때문에, 방향에 따라 선택할 것
  - 하나의 도구로 처리하는게 아닌
  - 각 도메인별로 쪼개 해당 기술 스택 활용

### 이미지 빌드(Image Build)
- AWS EC2, VMware, VirtualBox, Docker등 여러 플랫폼에서 재사용 가능한 **머신 이미지**를 빌드
- 대표적인 이미지 빌더
  - Packer(여러 플랫폼 지원), AWS EC2 Image Builder(AMI)

### 코드로 관리한다는 것(... as Code)
- 사람이 수동으로 처리하는 것을 **코드로 작성**하여 관리
  - 휴먼 에러 방지, 재사용성, 일관성
- sw 개발처럼 Git과 같은 **버전 관리 시스템**(VCS) 활용 가능
  - 코드 리뷰, 변경내용 추적, 버전 관리, 협업
- **선언형 설정**(Declarative Configuration)과 **절차형 설정**(Imperative Configuration)의 차이
  - 선언형 설정: Desired state, 상태를 정의하면, 상태에 맞게 적용
    - Terraform, Ansible
  - 절차형 설정: 순차적으로 명령어를 수행
    - e.g. 패키지 업데이트, nginx 설치, 방화벽 설정을 순서대로
    - Ansible, Shell script
