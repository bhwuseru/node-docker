#!/bin/bash

# docker composeで構築した環境を初期状態に戻す
# 注意： 構築したデータベースは削除される

# 1. .envrcを読み込み、プロジェクトディレクトリに移動
source .envrc && \
cd .${PROJECT_NAME} && \

# 2. Docker Composeを使って現在の環境を停止
docker-compose down && \

# 3. dangling（未使用の）Dockerイメージがあるかをチェック
none_images=$(docker images -f "dangling=true" -q)
if [ -n "$none_images" ]; then
    # 4. danglingイメージを削除
    docker rmi $(docker images -f "dangling=true" -q)
fi

# 5. データディレクトリ、初期化SQLファイル、.envファイルを削除
rm -rf './db/data' && rm -f './db/init/init.sql' && rm -f ".env" && \

# 6. プロジェクトディレクトリを元に戻す
cd ../ && \
mv .${PROJECT_NAME} '.devcontainer'
