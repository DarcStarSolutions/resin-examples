FROM balenalib/raspberrypi3-golang:1.11.2

ENV INITSYSTEM on
# ENV NATS_STREAMING_VERSION 0.11.2
ENV GOBIN $GOPATH/bin
# ENV OS linux
# ENV ARCH arm7

RUN apt-get -q update &&  apt-get install -yq --no-install-recommends \
    unzip && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# WORKDIR /go/src/github.com/resin-io-projects/resin-go-hello-world

COPY 	./gnatsd.conf /

ADD   https://github.com/nats-io/nats-streaming-server/releases/download/v0.11.2/nats-streaming-server-v0.11.2-linux-arm7.zip /nats-streaming-server.zip

RUN go get github.com/nats-io/go-nats/examples/nats-bench && \
    go install github.com/nats-io/go-nats/examples/nats-bench

RUN unzip /nats-streaming-server.zip && \
    mv nats-streaming-server-v0.11.2-linux-arm7/nats-streaming-server /nats-streaming-server && \
    rm -fr nats-streaming-server-v0.11.2-linux-arm7 /nats-streaming-server.zip && \
    mkdir -p /etc/gnatsd && \
    mkdir -p /data/log/nats

# VOLUME ["/etc/gnatsd", "/var/log/nats/" ]
# CMD ["go","run", "main.go" ]
# EXPOSE 4222 6222 8222
CMD ["/nats-streaming-server", "-c", "/gnatsd.conf"]
# CMD ["/nats-streaming-server"]
