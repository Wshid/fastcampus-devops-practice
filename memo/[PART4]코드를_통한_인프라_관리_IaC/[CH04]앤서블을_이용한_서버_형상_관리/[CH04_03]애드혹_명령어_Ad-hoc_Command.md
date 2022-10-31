## [CH04_03] 애드혹 명령어(Ad-hoc Command)

### Ansible 사용 방법
- Ansible Playbook
  - yaml
  - 특정 인벤토리에 수행
- ansible_pull
- Ad-hoc Command
  - playbook 설정 없이 간단한 명령 수행
  - 테스트 용도로 사용
- ...

### Ad-hoc command
```bash
ansible host-pattern -m module [-a 'module options'] [-i inventory]
```
- host-pattern: 그룹명
- `-i`: 인벤토리 파일 직접 지정

### 명령 수행 실습(Ping)
```bash
# ping 모듈 사용, 전체에 적용
# 유저 데이터를 지정하지 않았기 때문에, permission denied 발생
ansible -i amazon.inv -m ping all

# ec2-user로 수행
ansible -i amazon.inv -m ping all -u ec2-user

# -k 옵션을 주어 pw를 정의할 수 있음
# --private-key {key_path}
```
- ssh-agent에 private-key를 미리 등록했다면, 비밀번호 인증없이 바로 접근 가능

### Ansible Ping Module
- ping은 `ICMP ping`과는 다름
- 대상 호스트 연결
- 파이썬 사용 가능 여부 확인
- Control Node, Managed Node
  - Contorl Node
    - ansible 명령 노드
    - Ansible 설치 필요
  - Manage Node
    - 원격 노드
    - python 설치 필요

### 명령 수행 실습 2
```bash
ansible -i vars.inv -m command -a "uptime" ubuntu

# setup module: 상세(facts) 수집 모듈
# remote host 정보 수집
# localhost(명령 수행 노드), all(모든 호스트 포함)
# ansible 변수로 확인 가능
ansible localhost -m setup

# git 설치
# --become: 사용자 전환 옵션(default:root)
ansible -i vars.inv -m apt -a "name=git state=latest update_cache=yes" ubuntu --become

# git 설치 확인
ansible -i vars.inv -m command -a "git --version" ubuntu

# git 설치 제거(state: absent)
ansible -i vars.inv -m apt -a "name=git state=absent update_cache=yes" ubuntu --become
```