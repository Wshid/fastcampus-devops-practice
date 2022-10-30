# source -> builder 의미
# nullBuilder 정의
source "null" "one" {
  communicator = "none"
}

source "null" "two" {
  # provisioning과 연관(e.g. ssh)
  # provisioning 연결을 하지 X 의미
  communicator = "none"
}
