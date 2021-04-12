FROM ruby:2.6

RUN apt-get update

RUN apt-get install --assume-yes --no-install-recommends build-essential postgresql-client ca-certificates nodejs

ENV APP /usr/src/app

RUN mkdir -p $APP

WORKDIR $APP

COPY Gemfile* $APP/

RUN bundle install --jobs=$(nproc)

COPY . $APP/

CMD ["bin/rails", "db:create"]

CMD ["bin/rails", "db:migrate"]

CMD ["bin/rails", "server", "-p", "3000", "-b", "0.0.0.0"]