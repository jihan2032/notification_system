FROM ruby:2.6.5

WORKDIR /app

RUN apt-get update -qq && apt-get install

ADD Gemfile* /app/
RUN gem update --system
RUN bundle install

ADD . /app

EXPOSE 80
