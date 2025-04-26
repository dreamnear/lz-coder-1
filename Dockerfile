FROM codercom/enterprise-base:ubuntu
# 声明参数
# ARG HTTPS_PROXY

# # 设置环境变量
# ENV https_proxy=${HTTPS_PROXY}

USER root
RUN apt-get update \
    && apt-get install -y \
    sudo \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*
## 安装kubectl
RUN curl -LO "cdn.dl.k8s.io/release/v1.33.0/bin/linux/amd64/kubectl"
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl && \
    kubectl version --client

## 安装Telepresence
RUN curl -sSL https://github.com/telepresenceio/telepresence/releases/download/v2.14.1/telepresence-linux-amd64 -o /usr/local/bin/telepresence
RUN chmod +x /usr/local/bin/telepresence
RUN telepresence version

## 安装helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
RUN helm version

ARG USER=coder

USER coder
WORKDIR /home/coder
