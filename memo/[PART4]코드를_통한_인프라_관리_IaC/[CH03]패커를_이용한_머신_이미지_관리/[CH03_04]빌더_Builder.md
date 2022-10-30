## [CH03_04] 빌더 (Builder)
- `2-packer/02-builder/main.pkr.hcl`
- `2-packer/03-builder-full`
- 빌더
  - 어떤 머신 이미지를 만드는지 결정하는 요소
  - AWS EC2 AMI
  - Docker AMI
  - GCP Image AMI
- docs
  - https://developer.hashicorp.com/packer/docs/builders
- Amazon EC2
  - EBS 방법을 활용할 계획
- `Null` 빌더를 활용하여 실습

### 실습
- versions.pkr.hcl
  - 버전에 관련된 정보
- sources.pkr.hcl
- 빌드 방법
  ```bash
  packer build .
  ```