#
# slacktee
#
# build:
#   docker build --force-rm -t slacktee .
# run:
#   docker run --rm -it --name slacktee slacktee
#

FROM alpine:3.14
LABEL maintainer="FastCampus Park <fastcampus@fastcampus.com>"
LABEL description="Simple utility to send slack message easily."

# Install needed packages
## &&로 하나의 layer로 구성
## 패키지 설치시 --no-cache 옵션이 있는지 파악하기
## apk del --no-cache 등의 명령 수행이 가능한지 확인
RUN \
  apk add --no-cache bash curl git && \
  git clone https://github.com/course-hero/slacktee /slacktee && \
  apk del --no-cache git
RUN chmod 755 /slacktee/slacktee.sh

# Run
WORKDIR /slacktee
ENTRYPOINT ["/bin/bash", "-c", "./slacktee.sh"]
