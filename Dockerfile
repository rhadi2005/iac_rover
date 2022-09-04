###########################################################
# base tools and dependencies
###########################################################
FROM --platform=${TARGETPLATFORM} ubuntu:22.04 as base

SHELL ["/bin/bash", "-c"]

ENV TZ=Europe/Paris

# Arguments set during docker-compose build -b --build from .env file

ARG versionVault \
    versionKubectl \
    versionDockerCompose \
    versionPowershell \
    versionPacker \
    versionGolang \
    versionTerraformDocs \
    extensionsAzureCli \
    SSH_PASSWD \
    TARGETARCH \
    TARGETOS

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

ENV SSH_PASSWD=${SSH_PASSWD} \
    USERNAME=${USERNAME} \
    versionVault=${versionVault} \
    versionGolang=${versionGolang} \
    versionKubectl=${versionKubectl} \
    versionDockerCompose=${versionDockerCompose} \
    versionTerraformDocs=${versionTerraformDocs} \
    versionPacker=${versionPacker} \
    versionPowershell=${versionPowershell} \
    extensionsAzureCli=${extensionsAzureCli} \
    PATH="${PATH}:/opt/mssql-tools/bin:/home/vscode/.local/lib/shellspec/bin:/home/vscode/go/bin:/usr/local/go/bin" \
    TF_DATA_DIR="/home/${USERNAME}/.terraform.cache" \
    TF_PLUGIN_CACHE_DIR="/home/${USERNAME}/.terraform.cache/plugin-cache" \
    TF_REGISTRY_DISCOVERY_RETRY=5 \
    TF_REGISTRY_CLIENT_TIMEOUT=15 \
    ARM_USE_MSGRAPH=true \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

WORKDIR /tf/rover
COPY ./scripts/.kubectl_aliases .
COPY ./scripts/zsh-autosuggestions.zsh .

# Set the locale
#RUN apt-get clean && apt-get update && apt-get install -y locales

# installation common tools


    #
    # Create USERNAME
    #
RUN echo "Creating ${USERNAME} user..." && \
    groupadd docker && \
    useradd --uid $USER_UID -m -G docker ${USERNAME}  

    #
    # Set the locale
#RUN locale-gen en_US.UTF-8


#
# Switch to non-root ${USERNAME} context
#

USER ${USERNAME}

COPY .devcontainer/.zshrc $HOME
COPY ./scripts/sshd_config /home/${USERNAME}/.ssh/sshd_config



