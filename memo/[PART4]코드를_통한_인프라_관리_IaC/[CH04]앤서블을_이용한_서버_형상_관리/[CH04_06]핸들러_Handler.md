## [CH04_06] 핸들러 (Handler)
- `2-ansible/05-handler`
- Handler: 이벤트 기반으로 동작하는 Task
- e.g. nginx, apache 등의 server configuration이 변경될 때
- 유의 사항
  - Play 내에서 같은 이벤트를 여러번 호출되더라도, 동일한 핸들러는 한번만 수행
  - 모든 핸들러는 play내에 모든 작업이 **완료**된 후에 실행
  - 핸들러는 이벤트 호출 순서에 따라 실행되는 것이 아닌
    - **핸들러 정의 순서**에 따라 수행

### 코드 수행 방법
```bash
ansible-playbook -i inventory -D example.yaml
```