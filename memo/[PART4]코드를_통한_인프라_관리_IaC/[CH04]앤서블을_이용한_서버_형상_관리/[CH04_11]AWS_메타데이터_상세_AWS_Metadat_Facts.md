## [CH04_11] AWS 메타데이터 상세 (AWS Metadata Facts)
- `2-ansible/10-ec2-facts`

### 실습
```bash
# adhoc command
ansible -i default.inv ubuntu -m amazon.aws.ec2_metadata_facts
# 결과내 network 관련 내용을 많이 다룰 것
```