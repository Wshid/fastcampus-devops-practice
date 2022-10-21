## [CH02_22] (DynamoDB) Python으로 DynamoDB 접근
- 사전에 AWS CLI, `aws autoconfigure`가 설정되어 있어야 함
- region이 선택해야 dynamoDB 접근 가능

### 실습
```python
# in EC2
pip install boto3
pip3 install --upgrade awscli

mkdir python
cd python
vi dynamoaccess.py
```

#### dynamoaccess.py
```python
import boto3

client = boto3.client('dynamodb')
data = client.put_item(
  TableName = 'Orders',
  Item={
    'OrderID': {
      'S': '2'
    },
    'Date': {
      'S': '20211111'
    }
  }
)
```

#### command
```bash
python3 dynamoaccess.py
```
- 이후 dynamodb에 접근하여 추가된 데이터 확인

#### dynamoread.py
```python
import boto3
import json
client = boto3.client('dynamodb')

data = client.get_time(TableName='Orders', Key={
  'OrderID':{'S':'1'},
  'Date':{'S':'20211004'}}
  )
print(data)
```

#### Command
```python
```