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

# sudo実行時のパスワード入力を省略
RUN echo "node ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/node

# Node.jsをインストールし、npmをアップグレード
RUN apk add --no-cache nodejs npm
RUN npm install -g npm@latest

# ディレクトリを変更してからユーザーを切り替える
# WORKDIR /home/${USER}
WORKDIR /home/node

# node切り替える
USER node

CMD ["bash"]
