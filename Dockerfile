FROM golang:alpine as builder

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories #仓库代理

RUN apk add git
COPY ./* /opt/

RUN export GO111MODULE=on &&\
    export GOPROXY=https://goproxy.cn &&\
    cd /opt && \
    go env &&\
    ls /opt &&\
    go mod tidy && \
    go build main.go

FROM golang:alpine as final
COPY --from=builder /opt/main /opt/main

CMD ["/opt/main"]
