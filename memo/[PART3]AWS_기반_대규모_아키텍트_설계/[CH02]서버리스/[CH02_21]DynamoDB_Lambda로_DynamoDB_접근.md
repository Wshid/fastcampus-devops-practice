## [CH02_21] (DynamoDB) Lambda로 DynamoDB 접근
- DynamoDB를 Python으로 쓰기는 조금 어렵다고 함
- 실습에서는 nodejs 코드를 활용

### 실습
- Lambda 생성(nodejs)
- 권한
  - `AmazonDynamoDBFullAccess` 권한 추가
- 코드 작성
  ```js
  const AWS = require('aws-sdk');
  // 현재 Region에 맞게 지정
  const ddb = new AWS.DynamoDB.DocumentClient({'region': 'us-east-2'});
  exports.handler = async (event, context, callback) => {
    const requestId = context.awsRequestId;

    await createMessage(requestId).then(() => {
        callback(null, {
            statusCode: 201,
            body: '',
            headers: {
                'Access-Control-Allow-Origin': '*'
            }
        });
    }).catch((err) => {
        console.error(err)
    });
  };

  function createMessage(requestId) {
    const params = {
        TableName: 'Orders',
        Item: {
            'OrderID': requestId,
            'Date': '20211010'
        }
    }
    return ddb.put(params).promise();
  }
  ```
- Deploy
- Test
  - 이벤트 바디
    ```json
    {}
    ```
- 이후 DynamoDB 상에서 추가된 레코드 조회
