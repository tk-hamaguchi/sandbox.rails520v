FROM ruby:2.5

RUN apt-get update && apt-get install -qq -y --no-install-recommends apt-transport-https && apt-get dist-upgrade -y

RUN sh -c 'curl -sL https://deb.nodesource.com/setup_6.x | bash -'

RUN sh -c 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -'
RUN sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list'

RUN apt-get update && apt-get install -qq -y --no-install-recommends nodejs yarn && apt-get clean

RUN yarn global add bower


RUN mkdir /var/rails
WORKDIR /var/rails/

ADD Gemfile* /var/rails/
RUN bundle install --deployment --without development test

ADD yarn.lock /var/rails/
RUN yarn install --frozen-lockfile

ADD . /var/rails/

ENV TZ                       JST-9
ENV RAILS_MASTER_KEY         a4bedfac3c1be17b84d644f0817705a1
ENV DATABASE_URL             mysql2://root:mysql@mysqld/rails520v
ENV RAILS_LOG_TO_STDOUT      true
ENV RAILS_ENV                production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_MAX_THREADS        1
ENV ELASTICSEARCH_URL        http://elasticsearch:9200/
ENV REDIS_URL                redis://redis:6379/0
ENV SENTRY_DSN               http://localhost/rails520v
ENV WORKER                   1
ENV THREAD                   4:8
ENV PORT                     9292

EXPOSE $PORT

RUN bundle exec rake assets:precompile
RUN bundle binstubs bundler --force
RUN bundle exec webpack

HEALTHCHECK --interval=60s --timeout=3s CMD curl -f 'http://127.0.0.1:9292/version' || exit 1
#HEALTHCHECK --interval=60s --timeout=3s CMD curl -f 'http://127.0.0.1:9292/version?details=1' || exit 1

CMD bundle exec puma -e $RAILS_ENV --preload -p $PORT -w $WORKER -t $THREAD 

