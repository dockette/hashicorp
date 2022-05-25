FROM alpine:3.16 as builder

ENV NOMAD_VERSION=1.3.1
ENV CONSUL_VERSION=1.12.0
ENV VAULT_VERSION=1.10.3
ENV TERRAFORM_VERSION=1.2.1
ENV LEVANT_VERSION=0.3.1
ENV PACKER_VERSION=1.8.0
ENV WAYPOINT_VERSION=0.8.2

ADD https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip /hashicorp/nomad.zip
ADD https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip /hashicorp/consul.zip
ADD https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip /hashicorp/vault.zip
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip /hashicorp/terraform.zip
ADD https://releases.hashicorp.com/levant/${LEVANT_VERSION}/levant_${LEVANT_VERSION}_linux_amd64.zip /hashicorp/levant.zip
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip /hashicorp/packer.zip
ADD https://releases.hashicorp.com/waypoint/${WAYPOINT_VERSION}/waypoint_${WAYPOINT_VERSION}_linux_amd64.zip /hashicorp/waypoint.zip

RUN unzip -d /hashicorp /hashicorp/nomad.zip
RUN unzip -d /hashicorp /hashicorp/consul.zip
RUN unzip -d /hashicorp /hashicorp/vault.zip
RUN unzip -d /hashicorp /hashicorp/terraform.zip
RUN unzip -d /hashicorp /hashicorp/levant.zip
RUN unzip -d /hashicorp /hashicorp/packer.zip
RUN unzip -d /hashicorp /hashicorp/waypoint.zip
RUN chmod +x /hashicorp/*

FROM alpine:3.16

ENV GLIBC_VERSION=2.25-r0

ADD https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub
ADD https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk glibc.apk

RUN apk update && \
    apk upgrade && \
    apk --no-cache add bash curl make git glibc.apk  && \
    rm glibc.apk && \
    rm -rf /var/cache/apk/*

COPY --from=builder /hashicorp/nomad /usr/local/bin/nomad
COPY --from=builder /hashicorp/consul /usr/local/bin/consul
COPY --from=builder /hashicorp/vault /usr/local/bin/vault
COPY --from=builder /hashicorp/terraform /usr/local/bin/terraform
COPY --from=builder /hashicorp/levant /usr/local/bin/levant
COPY --from=builder /hashicorp/packer /usr/local/bin/packer
COPY --from=builder /hashicorp/waypoint /usr/local/bin/waypoint

ADD --chmod=+x bin/nomad-purge-job /usr/local/bin/nomad-purge-job
