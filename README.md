[クジラに乗った Ruby: Evil Martians 流 Docker+Ruby/Rails 開発環境構築（翻訳）｜ TechRacho by BPS 株式会社](https://techracho.bpsinc.jp/hachi8833/2022_04_07/116843)

この記事の開発環境が良かったので自分用にまとめる。Rails で開発する時はこれをベースに必要なもの/不要なものを Dockerfile や docker-compose から足し引きする。

# Clone

まずはリポジトリを clone しておく。`.git`は削除しておく。

```sh:sh
git clone git@github.com:YuheiNakasaka/docker-rails-basis.git sample-project
```

https://github.com/YuheiNakasaka/docker-rails-basis

# デフォルトの構成

この環境では下記の構成を作るのに必要そうなコンテナがデフォルトで作成される。

- Ruby(3.3)
- Rails(7.1)
- rubocop(formatter + linter)
- erblint
- PostgreSQL(14.0)
- Redis(7.0。セッション管理や sidekiq のキュー管理に使う)
- Hotwire

# 基本方針

VSCode + Dev Containers で開発することを想定。VSCode で`runner`というコンテナを立ち上げ、そこで gem をインストールしたり`rails`コマンドを叩いたりする。

# 開発環境の立ち上げ

`docker-compose.yml`の Ruby のバージョンを好きなものに変更しておく。[https://hub.docker.com/\_/ruby](https://hub.docker.com/_/ruby)にある tag を参考に。

```yml:docker-compose.yml
args:
  RUBY_VERSION: '3.1'
```

`image: example-dev:1.1.3`を好きな名前に変更しておく。

VSCode で Dev Containers を開く。

# Rails アプリの作成(初回のみ)

Rails の version は適宜変更する。

```Gemfile:Gemfile
source 'https://rubygems.org'
gem 'rails', '~> 7.1.0'
```

依存のインストール

```sh:sh
bundle install
```

アプリの作成。Hotwire を使う場合は下記で。

```sh:sh
bundle exec rails new . --force --database=postgresql --css=tailwind --javascript=importmap --skip-jbuilder -T
# skipオプションは下記を参考に
# bundle exec rails new . --force --database=postgresql --skip-action-mailer --skip-action-mailbox --skip-action-text --skip-active-job --skip-active-storage --skip-action-cable --skip-javascript --skip-hotwire --skip-jbuilder --skip-test --skip-system-test --skip-bootsnap --minimal
```

# Rspec/Rubocop/Erblint の設定

Gemfile に下記を追加して`bundle install`。

```
group :development, :test do
  gem 'debug', platforms: %i[ mri windows ]
  gem 'erb_lint'
  gem 'pry-rails'
  gem 'rubocop'
  gem 'rubocop-ast'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console'
  gem 'ruby-lsp'
end
```

## rspec の初期化

```sh:sh
bin/rails generate rspec:install
```

# DB の設定

DB の作成。

```sh:sh
bin/rails db:create
```

# Rails アプリの起動

起動。

```sh:sh
bin/dev
```

下記にアクセスすると welcome ページが表示される。

[http://0.0.0.0:3000/](http://0.0.0.0:3000/)

# その他

## Rails アプリの作成

Scaffold などを使って具体的なコードを書いていく。

## sidekiq の設定

[sidekiq/wiki](https://github.com/sidekiq/sidekiq/wiki)を見て ActiveJob などと連携しながら設定する。

## Dev Containers の再起動

fn > F1 > Dev Containers: Rebuild Containers

## Container の再ビルド

```
docker-compose build --no-cache
```

## 削除

fn > F1 > Remote: Close Remote Connection
