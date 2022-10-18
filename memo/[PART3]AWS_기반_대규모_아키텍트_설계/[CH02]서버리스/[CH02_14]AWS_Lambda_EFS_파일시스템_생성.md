## [CH02_14] (AWS Lambda) EFS 파일시스템 생성
- Elastic File System과 Lambda 연동

### 실습
- Amazon EFS 검색
- 파일 시스템 생성
  - 이름 설정
  - VPC 지정
    - EFS가 VPC 위에서 구동됨
  - 리전 지정
  - 완료
- 이름 선택
- 액세스 포인트
- 액세스 포인트 생성
  - 이름 설정
  - 루트 디렉터리 경로(`/message` 지정)
  - 사용자 ID, 그룹 ID 지정
    - 1001, 1001
  - 루트 디렉터리 생성 권한
    - 1001, 1001
    - POSIX: 750
  - 완료
- 네트워크
  - 관련 subnet 정보 확인 가능
  - **보안 그룹**이 중요
