## [CH03_14] (인프라) AWS KMS 개요

### 데이터 암호화(Data Encryption)
- 허가 받지 않은 외부의 침입자로부터
  - 데이터가 유출되거나 조작되지 않도록 보호하기 위한 수산
- 데이터의 실제 내용을 **허가된 사용자**만 확인할 수 있도록 은폐하는 기법
- 전송중인 데이터 암호화: Https
- 저장되어 있는 데이터 암호화
  - client-side 암호화(내가 직접)
  - Server-side 암호화(aws가 알아서)

#### Client-side 암호화
- 내가 직접 암호화키를 관리
- 필요하다면 AWS의 **KMS**를 활용할 수 있음

#### Server-side 암호화
- AWS가 알아서 서버에 저장된 데이터를 암호화
- 암호화 키를 자동으로 관리
- S3, RDS, EynamoDB, Redshift 등은 모두 암호화 기능을 기본으로 갖춤
- 암호화 키를 관리하기 위해 AWS의 KMS를 우리가 모르는 사이에 사용

### AWS KMS(Key Management Service)
- AWS의 encryption key를 관리하는 서비스
- 관리하는 암호화 키를 **CMK**(Customer Master Key)라 부름
- CMK를 **HSMs**(Hardware Security Modules)라는 저장소에 저장
- HSMs에 있는 CMK를 활용하기 위해 **KMS API**를 사용
- **AWS Cloudtrail**로 누가 어떤 Key를 어떻게 사용했는지 로그를 남김

#### Detail
- CMK는 생성된 **region**을 떠나지 않음(region 설정 필수)
- CMK를 통해선 최대 **4KB**의 데이터만 암호화 할 수 있음
- 더 큰 데이터를 암호화할 땐 CMK가 아닌 **data key**를 활용
- KMS는 **CMK**만 관리하고, **data key**는 관리하지 X
- Data keys는 **CMK**를 통해 생성
- 하나의 **CMK**를 통해 여러개의 **data keys**를 생성할 수 있음
- 일단 큰 데이터를 암호화하기 위해 **plaintext data key**를 활용하여 암호화
- 암호화가 끝난 뒤엔 **plaintext data key**를 삭제