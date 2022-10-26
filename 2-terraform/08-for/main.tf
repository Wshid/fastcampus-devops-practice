provider "aws" {
  region = "ap-northeast-2"
}

/*
 * Groups
 */

# iam_group 2개 생성
resource "aws_iam_group" "developer" {
  name = "developer"
}

resource "aws_iam_group" "employee" {
  name = "employee"
}

output "groups" {
  value = [
    aws_iam_group.developer,
    aws_iam_group.employee,
  ]
}


/*
 * Users
 */
# iam 사용자 변수 생성
# 참조하는 변수는 terraform.tfvars 내에 존재
variable "users" {
  type = list(any)
}

# iam 사용자 생성
resource "aws_iam_user" "this" {
  # map안에서 for문 사용
  for_each = {
    # key:user.name, value: user(유저 정보)
    for user in var.users :
    user.name => user
  }

  name = each.key

  tags = {
    level = each.value.level
    role  = each.value.role
  }
}

resource "aws_iam_user_group_membership" "this" {
  for_each = {
    for user in var.users :
    user.name => user
  }

  user   = each.key
  # 두 그룹에 사용자가 지정될 수 있도록(if is_developer is true)
  groups = each.value.is_developer ? [aws_iam_group.developer.name, aws_iam_group.employee.name] : [aws_iam_group.employee.name]
}

locals {
  # 개발자일 경우에만 유저 포함 리턴
  developers = [
    for user in var.users :
    user
    if user.is_developer
  ]
}

# 사용자 권한 관련
resource "aws_iam_user_policy_attachment" "developer" {
  for_each = {
    # developer 일 경우에만 권한 부여
    for user in local.developers :
    user.name => user
  }

  user       = each.key
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

  # 의존성 관리 속성
  # 해당 리소스가 어떤 리소스를 참조하는지 속성 부여 가능
  depends_on = [
    aws_iam_user.this
  ]
}

output "developers" {
  value = local.developers
}

output "high_level_users" {
  # 전체 사용자 목록을 iterate하여 리턴
  value = [
    for user in var.users :
    user
    if user.level > 5
  ]
}
