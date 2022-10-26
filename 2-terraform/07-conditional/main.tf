provider "aws" {
  region = "ap-northeast-2"
}


/*
 * Conditional Expression
 * Condtion ? If_True : If_False
 */
variable "is_john" {
  type = bool
  default = true
}

locals {
  # local message 변수에서 조건문 활용
  message = var.is_john ? "Hello John!" : "Hello!"
}

output "message" {
  value = local.message
}


/*
 * Count Trick for Conditional Resource
 */
# 조건에 따라 특정 리소스를 생성하는 메서드
variable "internet_gateway_enabled" {
  type = bool
  default = true
}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

# 필요에따라 생성해도 되고, 생성하지 않아도 되는 메서드
resource "aws_internet_gateway" "this" {
  # 생성 여부를 count에 따라 결정
  count = var.internet_gateway_enabled ? 1 : 0

  vpc_id = aws_vpc.this.id
}
