FROM ruby:2.5.3-alpine

ENV LANG ja_JP.UTF-8

RUN apk update && apk upgrade && \
    apk add --update --no-cache build-base imagemagick libgcc libxml2-dev libxslt-dev mysql-client mysql-dev nodejs ruby-dev ruby-json yaml yaml-dev zlib-dev && \
    gem install bundler

RUN mkdir /webapp
WORKDIR /webapp

COPY Gemfile /webapp/Gemfile
COPY Gemfile.lock /webapp/Gemfile.lock

RUN bundle install --jobs 4 --retry 3 && \
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . /webapp

EXPOSE 3000