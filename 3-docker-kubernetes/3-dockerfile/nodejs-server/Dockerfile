#
# nodejs-server
#
# build:
#   docker build --force-rm -t nodejs-server .
# run:
#   docker run --rm -it --name nodejs-server nodejs-server
#

# base image 지정
FROM node:16
# image의 metadata 설정
LABEL maintainer="FastCampus Park <fastcampus@fastcampus.com>"
LABEL description="Simple server with Node.js"

# Create app directory
# set working directory, cd를 통해 디렉터리를 이동하는것과 동일
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
# COPY src(host) dest(image)
## 호스트내의 package*.json을 이미지내 ./로 복사
COPY package*.json ./

## 아래 명령어 수행
RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
## 현재 디렉터리 내용을 컨테이너 내로 복사
## 소스코드의 변경사항을 복제하기 위함
## 한줄 한줄이 레이어를 의미
COPY . .

## 이 이미지가 8080 포트를 활용한다는 의미
## publising 의미가 아님, 실제 수행시 `-p 8080`으로 수행 필요
EXPOSE 8080

## 컨테이너 수행시, 수행할 명령어, main process
## 하나의 문자열 형태로도 전달 가능
CMD [ "node", "server.js" ]
