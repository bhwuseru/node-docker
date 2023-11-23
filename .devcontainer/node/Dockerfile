FROM node:18.18.2-alpine

# コンテナ内の環境変数を定義するための引数
ARG PROJECT_NAME
ARG PASSWORD
ARG USER

# 環境変数を設定する
ENV PROJECT_NAME=${PROJECT_NAME}
ENV USER=${USER}
ENV PASSWORD=${PASSWORD}

# ユーザーをルートに切り替える
USER root

# Bashをインストール
RUN apk add --no-cache bash

# sudoをインストール
RUN apk add --no-cache sudo

# ユーザーを作成し、必要なディレクトリに書き込み権限を付与する
RUN adduser -D -u 1001 ${USER} && \
    mkdir -p /home/${USER} && \
    chown -R ${USER}:${USER} /home/${USER} && \
    mkdir -p /home/${USER}/.npm && \
    chown -R ${USER}:${USER} /home/${USER}/.npm

# ユーザーのパスワードを設定
RUN echo "${USER}:${PASSWORD}" | chpasswd
# sudo実行時のパスワード入力を省略
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER}

# Node.jsをインストールし、npmをアップグレード
RUN apk add --no-cache nodejs npm
RUN npm install -g npm@latest

# ディレクトリを変更してからユーザーを切り替える
WORKDIR /home/${USER}

# node切り替える
USER node

CMD ["bash"]
