title: dockerfile for k8s to deploy golang program
date: 2022-05-30 08:59:41 +0800
update: ""
author: linx
tags: []
categories: []
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: post
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



UPDATE: 2022-06-21 更新dockerfile，使用更小的基础镜像。使用docker的分层概念，让打包使用缓存，打包更快
UPDATE: 2022-06-21 增加makefile 使用make来进行编译构建



```dockerfile
# 先使用特定的go环境的镜像进行打包
FROM golang:1.18 as build
MAINTAINER "linx <sulinke1133@gmail.com>"
ARG MODE=prod
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    TZ=Asia/Shanghai \
    GOOS=linux \
    GOARCH=amd64 \
	GOPROXY="https://goproxy.cn" \
	GOPRIVATE="gitee.com"

RUN mkdir /src
WORKDIR /src
ADD go.mod .
ADD go.sum .
# 到这一句为止， 只要go.mod未变化，就会使用缓存
# 也就是说不需要每次都下载mod了
RUN go mod download

COPY . .
RUN make all MODE=${MODE}

# 运行用的镜像
# 这个镜像在alpine基础上增加了 时区 和 根证书
FROM saranraj/alpine-tz-ca-certificates as prod
# 定义一个参数用于指定打包模式
ARG MODE=prod
# 指定时区
ENV TZ=Asia/Shanghai
RUN mkdir /app
WORKDIR /app

COPY --from=build /src/bin/app_name .
COPY --from=build /src/bin/app_name-cli .
# 根据参数MODE使用特定的配置文件 这样可以开发配置和正式环境配置使用俩文件
COPY --from=build /src/cmd/moon/config/config_$MODE.toml ./config.toml
RUN ln -fs /app/app_name /usr/bin/app_name  \
    && ln -fs /app/app_name-cli /usr/bin/app_name-cli

CMD ["app_name"]

```

再附上makefile

```makefile
# 获取一堆附加信息
gitCommit:=$(shell git rev-parse --short HEAD)
buildTime:=$(shell date -R)
branch:=$(shell git symbolic-ref --short HEAD)
GOVERSION:=$(shell go version)
# 指定一些路径啥的
BUILD_NAME:=bin/moon
CLI_NAME:=bin/moon-cli
CLI_SOURCE:=cmd/moon-cli/main.go
# 包名
PACKAGENAME:=<PACKAGENAME>
BUILD_VERSION:=0.1

GOOS:=linux
GOARCH:=amd64
CGO_ENABLED:=0
SOURCE:=cmd/moon/moon.go
# 拼接LDFLAGS
BUILDINFO:=-X ${PACKAGENAME}/pkg/buildinfo.Version=${BUILD_VERSION}
BUILDINFO:=${BUILDINFO} -X ${PACKAGENAME}/pkg/buildinfo.GitCommitId=${gitCommit}
BUILDINFO:=${BUILDINFO} -X ${PACKAGENAME}/pkg/buildinfo.ProjectName=moon
BUILDINFO:=${BUILDINFO} -X '${PACKAGENAME}/pkg/buildinfo.BuildTime=${buildTime}'
BUILDINFO:=${BUILDINFO} -X ${PACKAGENAME}/pkg/buildinfo.Branch=${branch}
BUILDINFO:=${BUILDINFO} -X '${PACKAGENAME}/pkg/buildinfo.GoVersion=${GOVERSION}'
BUILDINFO:=${BUILDINFO} -X '${PACKAGENAME}/pkg/buildinfo.OsArch=${GOOS}/${GOARCH}'
BUILDINFO:=${BUILDINFO} -X '${PACKAGENAME}/pkg/buildinfo.Mode=${MODE}'
LDFLAGS:=-ldflags "-s -w ${BUILDINFO}"
# 构建主体和cli
all: build cli

cli:
	GOOS=${GOOS} GOARCH=${GOARCH} go build -o ${CLI_NAME} ${CLI_SOURCE}

.PHONY: build

build: clean
	GOOS=${GOOS} GOARCH=${GOARCH} go build -o ${BUILD_NAME} ${LDFLAGS} ${SOURCE}
tidy:
	go mod tidy

clean:
	rm -f ${BUILD_NAME}
	rm -f ${CLI_NAME}

dev-image:
	docker build -t xxxxxxxx/linx/moon --build-arg MODE=dev .

dev-push: dev-image
	docker push xxxxxxx/linx/moon:latest

image:
	docker build -t xxxxxxx/xxxxxxx/moon:latest -t xxxxxxx/xxxxxxx/moon:${BUILD_VERSION} --build-arg MODE=prod .

push: image
	docker push xxxx/xxxx/moon:latest
	docker push xxxxxxx/xxxxxxx/moon:${BUILD_VERSION}
```

### 调用流程

- 执行 `make dev-push` -> 容器中执行 `make all MODE=dev` -> 镜像构建完成，打Tag -> 推送到内网的harbor -> k8s 重启部署 
- 执行 `make push` -> 容器中执行 `make all MODE=prod` -> 镜像构建完成，打Tag -> 推送到公网的镜像仓库 -> k8s 重启部署
