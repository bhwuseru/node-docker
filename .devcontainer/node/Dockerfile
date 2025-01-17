FROM node:21.7.3-slim

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

# rootユーザーに切替
USER root

# パッケージのインストール前に追加
SHELL ["/bin/bash", "-c"]

# パッケージのインストール
RUN apt-get clean && apt-get update \
  && apt-get install -y \
  sudo \
  locales \
  git \
  vim \
  && echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen \
  && locale-gen ja_JP.UTF-8 \
  && rm -rf /var/lib/apt/lists/*

# タイムゾーンを設定
ENV TZ=Asia/Tokyo

# 一般権限のユーザーを追加
RUN useradd -m -s /bin/bash ${USER} --uid 2000 && \
  echo "${USER}:${PASSWORD}" | chpasswd && \
  usermod -aG sudo ${USER}

# ホームディレクトリの権限を修正
RUN chown -R ${USER}:${USER} /home/${USER}

# VS Codeサーバー用ディレクトリの設定
RUN mkdir -p /home/${USER}/.vscode-server/data/Machine && \
  chown -R ${USER}:${USER} /home/${USER}/.vscode-server

# sudo実行時のパスワード入力を省略
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/${USER}

# .bashrcをコピー
COPY .bashrc /home/${USER}/.bashrc

# ユーザーの切替
USER node

# 作業ディレクトリに移動
WORKDIR /var/www/html


CMD ["bash"]