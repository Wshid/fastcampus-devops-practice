## [CH03_08] 후 처리기(Post-processor)
- https://developer.hashicorp.com/packer/docs/post-processors
- post-processor
- post-processors
  - post-processor을 여러개 가질 수 있는 형태

### 보편적으로 많이 사용되는 processor
#### Checksum
- 패커 -> 빌드 -> 산출물(artifact)
- artifact를 가지고 post-processor가 또 다른 산출물 생성
- 데이터 무결성 검증
- https://developer.hashicorp.com/packer/docs/post-processors/checksum

#### Compress
- 압축에 활용
- https://developer.hashicorp.com/packer/docs/post-processors/compress

#### Manifest
- build 과정에 대한 메타 정보를 저장
- https://developer.hashicorp.com/packer/docs/post-processors/manifest

#### Local Shell
- custom하게 후처리를 진행할때(in local)
- https://developer.hashicorp.com/packer/docs/post-processors/shell-local

### 실습
- `2-packer/06-post-processor`