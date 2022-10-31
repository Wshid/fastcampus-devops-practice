## [CH03_10] 패커 CLI 사용 방법 
- packer
  - build
  - init
  - fmt: 문법에 맞게 자동 정렬(Indentation)
  - inspect: packer의 청사진 파악
    ```bash
    packer instpect .
    ```
  - validate
    - 데이터 타입 체크 등 확인 가능
    - 올바른 동작을 위해, 문법을 틀려야 함
    ```bash
    packer validate .
    ```
  - version: packer 버전
  - fix: packer 버전업시 호환되도록 template 설정
  - hcl2_upgrade: json 포맷을 사용하다, hcl로 변환시
  - console: hcl을 expression으로 테스트