## [CH04_07] 변수 (Variables)
- `2-ansible/06-vars`
- https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html
- 변수명
  - ansible은 내부적으로 python으로 동작
  - `_` 사용 가능
- 변수 사용 방법
  - Jinja2 syntax를 따름
  - `{{ ... }}` 형태로 동작

### 수행 방법
- 변수들을 별도 파일(e.g. `vars.inv`)로 지정하여 수행하거나, `vars_files` 옵션으로 변수 파일을 지정하거나
- playbook 파일 내에서 정의 가능
- 변수 지정하는 방법은 22가지 경우가 있으나, 우선순위가 있음
```bash
ansible-playbook -i default.inv playbook.yaml
ansible-playbook -i vars.inv playbook.yaml
ansible-playbook -i default.inv playbook.yaml -e "user_comment=helloworld user_shell=/bin/sh"
ansible-playbook -i default.inv playbook.yaml -e "@vars.yamnl"
```