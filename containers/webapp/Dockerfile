FROM ruby:2.5.3-alpine

ENV LANG ja_JP.UTF-8

RUN apk update && apk upgrade && \
    apk add --update build-base imagemagick libgcc libxml2-dev libxslt-dev mysql-client mysql-dev nodejs ruby-dev ruby-json yaml yaml-dev zlib-dev && \
    gem install bundler

RUN mkdir /webapp
WORKDIR /webapp

COPY Gemfile /webapp/Gemfile
COPY Gemfile.lock /webapp/Gemfile.lock
RUN bundle install --jobs 4
COPY . /webapp

EXPOSE 3000