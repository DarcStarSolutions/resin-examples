FROM balenalib/raspberrypi3-golang:1.11.2-latest-build

ENV INITSYSTEM on
ENV NATS_STREAMING_VERSION 0.11.2
ENV GOBIN $GOPATH/bin
ENV OS linux
ENV ARCH arm7

RUN echo "$BURP"

RUN apt-get -q update
RUN apt-get full-upgrade

RUN apt-get install -yq --no-install-recommends \
 	build-essential unzip && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /go/src/github.com/resin-io-projects/resin-go-hello-world

COPY 	. ./


ADD https://github.com/nats-io/nats-streaming-server/releases/download/v${NATS_STREAMING_VERSION}/nats-streaming-server-v${NATS_STREAMING_VERSION}-${OS}-${ARCH}.zip /nats-streaming-server.zip


RUN unzip /nats-streaming-server.zip && \
    mv nats-streaming-server-v${NATS_STREAMING_VERSION}-${OS}-${ARCH}/nats-streaming-server /nats-streaming-server && \
    rm -fr nats-streaming-server-v${NATS_STREAMING_VERSION}-${OS}-${ARCH} /nats-streaming-server.zip && \
    mkdir -p /etc/gnatsd && \
    mkdir -p /var/log/nats


VOLUME ["/etc/gnatsd", "/var/log/nats/" ]

EXPOSE 4222 8222 6222

CMD ["/nats-streaming-server", "-c", "gnatsd.conf"]
# CMD ["ls","-lart", "/"]
# CMD ["/gnatsd", "-m", "8222" ]
