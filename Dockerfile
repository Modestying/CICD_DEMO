FROM golang:alpine as builder

RUN apk add --no-cache git gcc libc-dev curl
RUN mkdir /go-plugins
COPY ./* /opt/
#RUN curl https://raw.githubusercontent.com/Kong/go-plugins/master/go-hello.go -o /go-plugins/go-hello.go

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
