# 実行手順

`$ docker-compose build` 

`$ docker-compose run web rails db:create db:migrate` **初回のみ**

`$ docker-compose run web rails db:seed` **初回のみ**

`$ docker-compose up -d`

# ログの出力先
- 標準ログ: log/development.log
- エラーログ: