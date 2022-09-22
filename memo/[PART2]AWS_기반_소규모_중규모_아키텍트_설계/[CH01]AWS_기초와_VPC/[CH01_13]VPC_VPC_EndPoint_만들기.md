## [CH01_13] (VPC) VPC EndPoint 만들기
- private instance가 aws의 다양한 서비스를 활용하기 위함
- NAT Gateway로 참조하면 되지 않는가?
  - 그렇게 될 경우 외부 노출이 됨

### 작업 절차
- IAM 설정
  - S3에서 접근할 수 있는 역할 생성 필요
  - ![image](https://user-images.githubusercontent.com/10006290/191781156-b030604a-f029-40ca-9d58-e8476ef50650.png)
  - ![image](https://user-images.githubusercontent.com/10006290/191781424-d0fae41e-2bed-4133-9b6a-7a3fd681faf5.png)
- 역할 생성 완료
  - ![image](https://user-images.githubusercontent.com/10006290/191781676-4a13e5aa-0dc3-4e3d-8f25-eca95caecba8.png)

#### private EC2 생성
- ![image](https://user-images.githubusercontent.com/10006290/191782262-6a44910b-5ceb-4c75-9a85-740d60db989e.png)
  - 이 역할을 생성하는 EC2에 부여
  - custom-vpc, private-subnet 설정

#### Bastion Host 설정(public EC2)
- Bastion Host가 설정되어야 외부에서 private EC2 접근 및 설정이 가능하기 때문

#### 접근 방식
- 외부(local) -> public ec2 -> private ec2

#### S3 버킷 생성
- s3 검색 이후 버킷 생성

#### private ec2
```bash
# 현재 접근 안됨
aws s3 ls --region ap-northeast-2
```

#### Endpoint 생성
- AWS 서비스
- s3 Gateway 유형 선택
- custom VPC 선택
- ![image](https://user-images.githubusercontent.com/10006290/191784285-5c0ddf68-0a45-4940-81e6-9e5716213459.png)
- Endpoint는 public subnet과의 접점이 없음
  - 단순히 private subnet에서 활용
- 이후 routing table에 무언가가 생성됨
  - ![image](https://user-images.githubusercontent.com/10006290/191785311-5ffa9e68-b920-411f-b3c1-ac34ee2242e9.png)
- s3만 선택했기 때문에, 해당 서비스에 대해서만 허용된 구조
