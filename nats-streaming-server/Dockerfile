FROM balenalib/raspberrypi3-golang:1.11.2-run

ENV INITSYSTEM on
ENV NATS_STREAMING_VERSION 0.11.2
ENV GOBIN $GOPATH/bin
ENV OS linux
ENV ARCH arm7

RUN apt-get -q update &&  apt-get install -yq --no-install-recommends \
   wget unzip && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /go/src/github.com/resin-io-projects/resin-go-hello-world

COPY 	./* ./

RUN wget -O  /nats-streaming-server.zip https://github.com/nats-io/nats-streaming-server/releases/download/v${NATS_STREAMING_VERSION}/nats-streaming-server-v${NATS_STREAMING_VERSION}-${OS}-${ARCH}.zip


RUN unzip /nats-streaming-server.zip && \
    mv nats-streaming-server-v${NATS_STREAMING_VERSION}-${OS}-${ARCH}/nats-streaming-server /nats-streaming-server && \
    rm -fr nats-streaming-server-v${NATS_STREAMING_VERSION}-${OS}-${ARCH} /nats-streaming-server.zip && \
    mkdir -p /etc/gnatsd && \
    mkdir -p /var/log/nats

RUN ls -lrt

VOLUME ["/etc/gnatsd", "/var/log/nats/" ]
CMD ["/bin/sh", "./stall.sh" ]
# EXPOSE 4222, 6222, 8222
# CMD ["/nats-streaming-server", "-c", "gnatsd.conf"]
#CMD ["/nats-streaming-server"]
