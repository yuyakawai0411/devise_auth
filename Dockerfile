FROM ruby:2.6.5

ENV RAILS_ENV="development"

#nodejsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs

# yarnのインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y yarn

WORKDIR /app


COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /app
