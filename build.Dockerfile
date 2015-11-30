FROM golang:1.5

RUN go get github.com/Masterminds/glide
RUN go get github.com/golang/lint/golint

# enable GO15VENDOREXPERIMENT
ENV GO15VENDOREXPERIMENT 1

WORKDIR /go/src/github.com/mathieu-pousse/srp

COPY glide.yaml glide.yaml
RUN glide up

COPY . /go/src/github.com/mathieu-pousse/srp

