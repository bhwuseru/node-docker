FROM node:20.14.0-alpine3.20

# コンテナ内の環境変数を定義するための引数
ARG PROJECT_NAME
ARG PASSWORD
ARG USER

# 環境変数を設定する
ENV PROJECT_NAME=${PROJECT_NAME}
ENV USER=${USER}
ENV PASSWORD=${PASSWORD}

# ロケール設定
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:jp
ENV LC_ALL ja_JP.UTF-8
RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen

# タイムゾーンを設定
ENV TZ=Asia/Tokyo

# ユーザーをルートに切り替える
USER root

# Bashをインストール
RUN apk add --no-cache bash
# gitをインストール
RUN apk add --no-cache git

# sudoをインストール
RUN apk add --no-cache sudo

# sudo実行時のパスワード入力を省略
RUN echo "node ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/node

# Node.jsをインストールし、npmをアップグレード
RUN apk add --no-cache nodejs npm
RUN npm install -g npm@latest

# .bashrcをコピー
COPY .bashrc /home/node/.bashrc

# ディレクトリを変更してからユーザーを切り替える
WORKDIR /home/node

# nodeユーザーに切り替える
USER node

CMD ["bash"]
