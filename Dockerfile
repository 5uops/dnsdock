FROM alpine

ENV GOLANG_VERSION 1.6.3
ENV GOPATH /go
ENV CGO_ENABLED 0
ENV PATH ${PATH}:/go/bin
ENV CGO_ENABLED=0

RUN apk update \
    && apk upgrade \
    && apk add go>${GOLANG_VERSION} go-tools>${GOLANG_VERSION} git

ADD . /go/src/github.com/aacebedo/dnsdock
WORKDIR /go/src/github.com/aacebedo/dnsdock

RUN go get -v github.com/tools/godep \
    && godep restore
WORKDIR /go/src/github.com/aacebedo/dnsdock/src
RUN go build -o /tmp/output/dnsdock \
    && cp /tmp/output/dnsdock /go/bin/dnsdock

ENTRYPOINT ["/go/bin/dnsdock"]
