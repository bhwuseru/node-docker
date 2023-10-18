#!/bin/sh

# プロジェクトディレクトリが存在しないnextjsを新規インストール
if [ ! -d /home/$$USER/$PROJECT_NAME ]; then
	npx create-next-app@latest $PROJECT_NAME
fi

