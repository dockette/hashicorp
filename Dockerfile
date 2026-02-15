FROM debian:bookworm-slim AS builder

ARG TARGETARCH

ENV NOMAD_VERSION=1.11.2
ENV CONSUL_VERSION=1.22.3
ENV VAULT_VERSION=1.21.3
ENV TERRAFORM_VERSION=1.14.5
ENV LEVANT_VERSION=0.4.0
ENV PACKER_VERSION=1.15.0
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

COPY --from=builder --chmod=0755 /hashicorp/nomad/nomad /usr/local/bin/nomad
COPY --from=builder --chmod=0755 /hashicorp/consul/consul /usr/local/bin/consul
COPY --from=builder --chmod=0755 /hashicorp/vault/vault /usr/local/bin/vault
COPY --from=builder --chmod=0755 /hashicorp/terraform/terraform /usr/local/bin/terraform
COPY --from=builder --chmod=0755 /hashicorp/levant/levant /usr/local/bin/levant
COPY --from=builder --chmod=0755 /hashicorp/packer/packer /usr/local/bin/packer
COPY --from=builder --chmod=0755 /hashicorp/waypoint/waypoint /usr/local/bin/waypoint

ADD --chmod=0755 bin/nomad-purge-job /usr/local/bin/nomad-purge-job
