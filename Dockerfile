FROM alpine

ENV GOLANG_VERSION 1.6.3
ENV GOPATH /go
ENV PATH ${PATH}:${GOPATH}/bin
ENV CGO_ENABLED=0

RUN apk update \
    && apk upgrade \
    && apk add go>${GOLANG_VERSION} go-tools>${GOLANG_VERSION} git musl-dev

RUN go get -v github.com/tools/godep
RUN go get -u github.com/golang/lint/golint
RUN go get github.com/ahmetb/govvv

ADD . ${GOPATH}/src/github.com/aacebedo/dnsdock
WORKDIR ${GOPATH}/src/github.com/aacebedo/dnsdock
RUN godep restore
WORKDIR ${GOPATH}/src/github.com/aacebedo/dnsdock/src
RUN go build -o /tmp/output/dnsdock \
    && cp /tmp/output/dnsdock /go/bin/dnsdock

ENTRYPOINT ["/go/bin/dnsdock"]
