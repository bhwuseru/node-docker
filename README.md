# Next.jsの環境構築
- [Next.jsの環境構築](#nextjsの環境構築)
	- [Next.jsのdocker-compose環境構築手順](#nextjsのdocker-compose環境構築手順)
	- [docker-composeリソースの削除手順](#docker-composeリソースの削除手順)
	- [自動化スクリプト](#自動化スクリプト)

## Next.jsのdocker-compose環境構築手順
1. ルートディレクトリ直下の`.env.example`を.envrcにリネームしてポート設定やプロジェクト名などの設定を編集をする。
**ポートはホスト側のポートと衝突しないようにする。**
```
# 例
ROJECT_NAME=nextjs
APP_NAME=nextjs
DB_DATABASE=nextjs_db
DB_USER=user
USER=user
DB_PASSWORD=password
PROXY_PUBLIC_PORT=29100
PROXY_SSH_PORT=
PHP_MYADMIN_PUBLIC_PORT=29101
NODE_PORT=29102
MEMORY_LIMIT=128M
UPLOAD_LIMIT=64M
```

2. プロジェクトルートディレクトリで `. ./bin/gene_docker_compose_env.sh`
- スクリプトを実行するとルートディレクトリ直下の.devcontainerディレクトリ名が .${PROJECT_NAME}に変更される。
- .${PROJECT_NAME}/db/init/init.sqlが新規作成される。内容は.envrcで設定したDB_DATABASEの作成スクリプトが記載される。
- 上記はdocker-compose.yml: dbサービスのvolumes内 ./db/init:/docker-entrypoint-initdb.dで初回にテーブルを新規作成してくれる。

3. `cd ./.${PROJECT_NAME}`
4. `docker-compose build --no-cache`
5. `docker-compose up -d`
6. dockerプラグインのダッシュボードから${RPOJECT_NAME}-nodeにアタッチ
7. `npx create-next-app@latest ${PROJECT_NAME}` または マウント先の直下のinstall.shスクリプトを実行。
8. パーミッションエラーが出た場合は `chmod -R 777 対象のディレクトリ`を実行。

. nginxの静的ファイルを生成する場合はnext.config.js.exampleの内容をnextjsプロジェクトのnext.config.jsに上書きする。
その状態で`npm run build`を実行するとnextjsプロジェクト直下にoutディレクトリが作成される。
`.${PROJECT_NAME}/proxy/default.conf.template`内 `root   /var/www/html/${PROJECT_NAME}/out;` が nginxのルートになっている。

## docker-composeリソースの削除手順

1. `docker-compose down`を実行
2. `sudo rm -f .${PROJECT_NAME}/db/init/init.sql`削除
4. `sudo rm -f .${PROJECT_NAME}/.env` .envファイル削除
3. `sudo rm -rf .${PROJECT_NAME}/db/data` ディレクトリを削除
5. `.${PROJECT_NAME}`ディレクトリ名をを.devcontainerに変更


## 自動化スクリプト

.envrcファイルの環境変数を設定してから以下コマンドを実行すると、docker-composeのコンテナを立ち上げまでを自動実行する。

1. `.envrc`ファイルの環境変数を設定
2. nextjs_envディレクトリ直下で実行する。立ち上げは下記コマンドを実行
- `sudo bash ./bin/setup_docker_environment.sh`
3. nextjs_envディレクトリ直下で実行する。立ち上げた環境を初期状態に戻す
- `sudo bash ./bin/reset_docker_environment.sh `
