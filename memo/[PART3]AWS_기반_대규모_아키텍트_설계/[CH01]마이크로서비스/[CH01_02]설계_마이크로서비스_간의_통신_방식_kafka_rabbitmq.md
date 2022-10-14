## [CH01_02] (설계) 마이크로서비스 간의 통신 방식 (Kafka, RabbitMQ)

### 마이크로서비스 통신 패턴

#### Synchronous Solution
- 동기적
- Resp API
- 서비스 A에서 서비스 B로 직접 요청을 보내고 동기적으로 응답을 기다림

#### Asynchronous Messaging
- 비동기적
- 메세지 브로커를 사용하여 서비스 A에서 서비스 B로 메세지를 보냄
- 서비스 A는 응답을 기다리지 X
- 서비스 B는 일반적으로 동일한 **메세징 시스템**을 통해 결과를 사용할 수 있을때
  - (결과가 예상되는 경우) 결과를 보냄
- `RabbitMQ`와 `Apache Kafka`

### Synchronous Solution의 문제점
- A와 B와 통신을 할때, 서비스 B가 오프라인 상태가 되었다면
  - 어디에 요청을 저장하고 어디에서 다시 시도할 것인가
  - 응답을 기다리는 동안, 오래걸리거나 실패할 수 있음
- A와 B가 독립적이지 않음

### Asyncoronous Messeging
- Producer에서 Consumer로 메세지를 전달하는 **메세지 브로커**
- broker는 P에서 메세지를 수신하여 C에게 메세지 전달
- broker는 Consumer의 연결이 끊어졌을 때, 임시 메세지 저장소를 제공
- **Micro Service** 별로의 **독립성** 확보

