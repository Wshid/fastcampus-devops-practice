provider "aws" {
  region = "ap-northeast-2"
}

/*
 * No count / for_each
 */
resource "aws_iam_user" "user_1" {
  name = "user-1"
}

resource "aws_iam_user" "user_2" {
  name = "user-2"
}

resource "aws_iam_user" "user_3" {
  name = "user-3"
}

output "user_arns" {
  value = [
    aws_iam_user.user_1.arn,
    aws_iam_user.user_2.arn,
    aws_iam_user.user_3.arn,
  ]
}


/*
 * count
 */
# terraform 초기 버전부터 지원
# resource/data/module 등에 활용 가능
resource "aws_iam_user" "count" {
  # meta_argument
  count = 10
  # index를 가져오는 방법(0~9)
  name = "count-user-${count.index}"
}

output "count_user_arns" {
  # count로 생성된 내용은 list형태와 유사
  # list 전체 적용 코드
  value = aws_iam_user.count.*.arn
}


/*
 * for_each
 */
# count를 보완하기 위함
resource "aws_iam_user" "for_each_set" {
  # set, map을 지원
  # set(unique element list), map(key:value)
  # set을 활용하는 경우
  # [] 만 사용하게 되면 Listf로 인식
  for_each = toset([
    "for-each-set-user-1",
    "for-each-set-user-2",
    "for-each-set-user-3",
  ])
  # each.key, each.value를 통해 원소별 접근 가능
  # set의 경우 key, value 동일값 리턴
  name = each.key
}

output "for_each_set_user_arns" {
  # object에서 values만 뽑는 과정(cf. keys 도 존재)
  # values만 가져오면 user object를 가져올 수 있음
  value = values(aws_iam_user.for_each_set).*.arn
}

resource "aws_iam_user" "for_each_map" {
  # for_each map을 활용, key는 string이어야 함
  # value의 경우 타입을 구분하지 않음
  for_each = {
    # key:alice, value:object
    alice = {
      level = "low"
      manager = "posquit0"
    }
    bob = {
      level = "mid"
      manager = "posquit0"
    }
    john = {
      level = "high"
      manager = "steve"
    }
  }
  # alice, bob, john
  name = each.key
  # object 리스트
  tags = each.value
}

output "for_each_map_user_arns" {
  value = values(aws_iam_user.for_each_map).*.arn
}
