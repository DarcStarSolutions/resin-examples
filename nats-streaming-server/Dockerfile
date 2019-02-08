FROM balenalib/raspberrypi3-golang:1.11.2

ENV NATS_STREAMING_VERSION 0.11.2
ENV GOBIN $GOPATH/bin
ENV OS linux
ENV ARCH arm7

RUN apt-get -q update
RUN apt-get install -yq --no-install-recommends \
 	unzip && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /go/src/github.com/resin-io-projects/resin-go-hello-world

COPY 	./gnatsd.conf .


ADD https://github.com/nats-io/nats-streaming-server/releases/download/v${NATS_STREAMING_VERSION}/nats-streaming-server-v${NATS_STREAMING_VERSION}-${OS}-${ARCH}.zip /nats-streaming-server.zip


RUN unzip /nats-streaming-server.zip && \
    mv nats-streaming-server-v${NATS_STREAMING_VERSION}-${OS}-${ARCH}/nats-streaming-server /nats-streaming-server && \
    rm -fr nats-streaming-server-v${NATS_STREAMING_VERSION}-${OS}-${ARCH} /nats-streaming-server.zip && \
    mkdir -p /etc/gnatsd && \
    mkdir -p /var/log/nats


VOLUME ["/etc/gnatsd", "/var/log/nats/" ]

CMD ["/nats-streaming-server", "-c", "gnatsd.conf"]
