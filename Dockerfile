FROM alpine

ENV GOLANG_VERSION 1.6.3
ENV GOPATH /go
ENV PATH ${PATH}:${GOPATH}/bin

RUN apk update \
    && apk upgrade \
    && apk add go>${GOLANG_VERSION} go-tools>${GOLANG_VERSION} git

RUN go get -v github.com/tools/godep
ADD . ${GOPATH}/src/github.com/aacebedo/dnsdock
WORKDIR ${GOPATH}/src/github.com/aacebedo/dnsdock
RUN godep restore
WORKDIR ${GOPATH}/src/github.com/aacebedo/dnsdock/src
RUN go build -o /tmp/output/dnsdock \
    && cp /tmp/output/dnsdock /go/bin/dnsdock

ENTRYPOINT ["/go/bin/dnsdock"]
