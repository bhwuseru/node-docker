#!/bin/bash

# docker-compose環境のセットアップとコンテナの起動する

# 1. .env ファイルのパスを設定
envfile_path="$(pwd)/.devcontainer/.env"

# 2. もし .env ファイルが存在する場合は削除
if [ -f $envfile_path ]; then
    rm -f $envfile_path
fi

# 3. Docker Composeの環境設定を生成および実行
. ./bin/gene_docker_compose_env.sh && \
source .envrc && \
cd .${PROJECT_NAME} 

# 4. dangling Dockerイメージの削除
none_images=$(docker images -f "dangling=true" -q)
if [ -n "$none_images" ]; then
    docker rmi $(docker images -f "dangling=true" -q)
fi

# 5. Docker Composeを使用してコンテナをビルドおよび起動
docker-compose build --no-cache && \
docker-compose up -d && \

# 6. 実行したファイルのディレクトリ位置に戻る
cd ..
