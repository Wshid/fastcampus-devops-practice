## [CH03_15] (인프라) AWS KMS 활용 실습(SDK 활용)
- 참고 링크: https://docs.aws.amazon.com/ko_kr/encryption-sdk/latest/developer-guide/python-example-code.html 

### KMS 설정
- 서비스 검색: KMS
- 키 생성: 대칭
- 레이블 추가: 이름 지정
- 키 사용 권한 정의:
  - IAM에서 사용자 지정
- EC2 생성
  - 기존 인스턴스에서 생성해도 되나, 꼬임 문제가 발생할 수 있어
  - 아예 새로 생성

#### EC2 내부 명령 수행
```bash
sudo apt update
sudo apt install awscli
aws configure

sudo apt isntall python3-pip
pip isntall aws-encryption-sdk
```

#### encrypting.py
```python
import aws_encryption_sdk
from base64 import b64encode
from aws_encryption_sdk import CommitmentPolicy

# client에서 사용하기 위한 설정, 가장 기본 정책으로 설정
client = aws_encryption_sdk.EncryptionSDKClient[commitment_policy=CommitmentPolicy.REQUIRE_ENCRYPT_REUQIRE_DECRYPT]

key_arn ="arn:aws...."
source_plaintext="hi"

kms_kwargs = dict(key_ids=[key_arn])
master_key_provider = aws_encryption_sd.StrickAwsKmsMasterKeyProvider(**kms_kwargs)

# ciphertext: 암호화된 텍스트
ciphertext, encryptor_header = client.encrypt(source=source_plaintext, key_provider=master_key_provider)
print(ciphertext)

cycled_plaintext, decypted_header = client.decrypt(source=ciphertext, key_provider=master_key_provider)
```
