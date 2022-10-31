## [CH04_04] 플레이북(Playbook)
- yaml 문법
- `2-ansible/03-playbook`

### 실습
```bash
# play 순서에 따라 진행
ansible-playbook -i invetory install-nginx.yaml

# adhoc 명령어 수행, nginx가 정상적으로 설치되었는지 확인하기 위함
ansible -i inventory amazon -m command -a "curl localhost"

# 제거 playbook 수행
ansible-playbook -i inventory uninstall-nginx.yaml

ansible -i inventory ubuntu -m command -a "curl localhost"
ansible -i inventory amazon -m command -a "curl localhost"
```
- task 결과 확인시
  - `changed`: 이전 상태와 변화가 있음
  - `ok`: 이전 상태에서 변화가 x