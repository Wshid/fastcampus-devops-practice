## [CH03_09] AWS 계정 MFA 활성화
- MFA(Multi Factor Authentication)
  - 다단계 인증
  - 정규 자격증명 방법외, 서비스 제공자가 지원하는 추가 인증 방법 수행
    - e.g. SMS, Email, OTP, Yubikey, ...

### AWS의 다단계 인증
- AWS root 계정 및 **IAM 사용자**에 적용 가능
- 웹 콘솔 로그인 및 CLI 사용 모두에 적용 가능
- 지원하는 MFA 유형
  - 가상 MFA 디바이스: mobile app
  - U2F 보안키
  - 다른 하드웨어 MFA 디바이스: 은행 OTP
  - SMS 기반 MFA
    - IAM 사용자만 사용 가능

### 가상 MFA 디바이스
- Google Authenticator
  - 추천하지 x
  - 휴대폰을 잃어버리면 복구방법이 거의 없음
- Authy: 무료, 클라우드에 저장
- Azure Authenticator
- 1Password: 유료, 클라우드에 저장

### AWS 설정 방법
- ![image](https://user-images.githubusercontent.com/10006290/191014127-35c40ec4-3fc0-4296-90db-2c078d1e135b.png)
- Google Authenticator 사용
