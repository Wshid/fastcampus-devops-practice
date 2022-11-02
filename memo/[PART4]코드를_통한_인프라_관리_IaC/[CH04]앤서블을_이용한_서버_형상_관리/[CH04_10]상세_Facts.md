## [CH04_10] 상세 (Facts)
- remote system의 여러 상세 정보를 확인
  - os, ip, fs
- https://docs.ansible.com/ansible/latest/user_guide/playbooks_vars_facts.html
- `2-ansible/09-facts`

### facts 수집 방법
```bash
# 해당 인스턴스의 fact 수집
ansible localhost -m setup
# 필터 조건 사용
ansible localhost -m setup -a "filter=ansible_districution*"
```