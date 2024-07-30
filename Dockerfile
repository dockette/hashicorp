FROM debian:bookworm-slim as builder

ARG TARGETARCH

ENV NOMAD_VERSION=1.8.2
ENV CONSUL_VERSION=1.19.1
ENV VAULT_VERSION=1.17.2
ENV TERRAFORM_VERSION=1.9.3
ENV LEVANT_VERSION=0.3.3
ENV PACKER_VERSION=1.11.1
ENV WAYPOINT_VERSION=0.11.4

ADD https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_${TARGETARCH}.zip /hashicorp/nomad.zip
ADD https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_${TARGETARCH}.zip /hashicorp/consul.zip
ADD https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_${TARGETARCH}.zip /hashicorp/vault.zip
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TARGETARCH}.zip /hashicorp/terraform.zip
ADD https://releases.hashicorp.com/levant/${LEVANT_VERSION}/levant_${LEVANT_VERSION}_linux_${TARGETARCH}.zip /hashicorp/levant.zip
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_${TARGETARCH}.zip /hashicorp/packer.zip
ADD https://releases.hashicorp.com/waypoint/${WAYPOINT_VERSION}/waypoint_${WAYPOINT_VERSION}_linux_${TARGETARCH}.zip /hashicorp/waypoint.zip

RUN apt update && \
    apt upgrade -y && \
    apt install -y unzip

RUN unzip -d /hashicorp/nomad /hashicorp/nomad.zip
RUN unzip -d /hashicorp/consul /hashicorp/consul.zip
RUN unzip -d /hashicorp/vault /hashicorp/vault.zip
RUN unzip -d /hashicorp/terraform /hashicorp/terraform.zip
RUN unzip -d /hashicorp/levant /hashicorp/levant.zip
RUN unzip -d /hashicorp/packer /hashicorp/packer.zip
RUN unzip -d /hashicorp/waypoint /hashicorp/waypoint.zip

FROM debian:bookworm-slim

RUN apt update && \
    apt upgrade -y && \
    apt install -y bash curl make git && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

COPY --from=builder --chmod=+x /hashicorp/nomad/nomad /usr/local/bin/nomad
COPY --from=builder --chmod=+x /hashicorp/consul/consul /usr/local/bin/consul
COPY --from=builder --chmod=+x /hashicorp/vault/vault /usr/local/bin/vault
COPY --from=builder --chmod=+x /hashicorp/terraform/terraform /usr/local/bin/terraform
COPY --from=builder --chmod=+x /hashicorp/levant/levant /usr/local/bin/levant
COPY --from=builder --chmod=+x /hashicorp/packer/packer /usr/local/bin/packer
COPY --from=builder --chmod=+x /hashicorp/waypoint/waypoint /usr/local/bin/waypoint

ADD --chmod=+x bin/nomad-purge-job /usr/local/bin/nomad-purge-job
