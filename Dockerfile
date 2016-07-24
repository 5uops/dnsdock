FROM alpine

ENV GOLANG_VERSION 1.6.2-r4
ENV GOPATH /go
ENV CGO_ENABLED 0
ENV PATH ${PATH}:/go/bin
ENV CGO_ENABLED=0

RUN apk update \
    && apk upgrade \
    && apk add go>${GOLANG_VERSION} go-tools>${GOLANG_VERSION} git

ADD . /go/src/github.com/dnsdock
WORKDIR /go/src/github.com/dnsdock
RUN go get -v github.com/tools/godep
RUN godep restore
RUN go install -ldflags "-X main.version `git describe --tags HEAD``if [[ -n $(command git status --porcelain --untracked-files=no 2>/dev/null) ]]; then echo "-dirty"; fi`"
