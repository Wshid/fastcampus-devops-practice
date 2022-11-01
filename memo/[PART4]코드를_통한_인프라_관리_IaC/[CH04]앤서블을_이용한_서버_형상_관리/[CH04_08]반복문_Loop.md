## [CH04_08] 반복문 (Loop)
- `2-ansible/07-loop`
- https://docs.ansible.com/ansible/latest/user_guide/playbooks_loops.html
- 반복문 문법은 3가지 존재
  - `loop`
    - ansible 2.5부터 지원
  - `with <lookup>`
  - `until`(retry시 사용)

### 수행방법
```bash
ansible-playbook -i default.inv playbook.yaml
```