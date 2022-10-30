/**
 * Without Name
 */
# build 블록을 정의하여 reference 정의
# sources 내용은 순서 무관
build {
  sources = [
    "source.null.one",
    "source.null.two",
  ]
}

/**
 * With Name
 */
build {
  # 빌드 프로세서에 이름 지정
  # build 블록은 한 파일내 여러개 지정 가능
  name    = "fastcampus-packer"

  sources = [
    "source.null.one",
    "source.null.two",
  ]
}

/**
 * Fill-in
 */
build {
  name    = "fastcampus-packer-fill-in"

  # source 블록 재정의
  # extends 의미(override가 아닌)
  # null.one -> null.terraform으로 이름 변경
  # overwrite는 기본적으로 불가(e.g. 아래의 경우 communicator의 경우 재정의 불가)
  source "null.one" {
    name = "terraform"
  }

  source "null.two" {
    name = "vault"
  }
}
