FROM alpine:latest
RUN apk --no-cache add \
    ca-certificates

COPY ./seeker-k8s-agent-injector /opt/seeker/seeker-k8s-agent-injector

ENTRYPOINT ["/opt/seeker/seeker-k8s-agent-injector"]
