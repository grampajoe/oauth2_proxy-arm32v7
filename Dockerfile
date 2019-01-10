FROM arm32v7/golang:1.11

ENV VERSION=v2.2

RUN go get -d github.com/bitly/oauth2_proxy && \
    cd /go/src/github.com/bitly/oauth2_proxy && \
    git checkout $VERSION && \
    CGO_ENABLED=0 go get

FROM centurylink/ca-certs

COPY --from=0 /go/bin/oauth2_proxy /bin/oauth2_proxy

ENTRYPOINT ["/bin/oauth2_proxy"]
