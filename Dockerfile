# syntax = docker/dockerfile:1.0-experimental

#  ruby version to use
ARG RUBY_VERSION=3.2.0

FROM ruby:${RUBY_VERSION}-slim as base

WORKDIR /app
COPY . /app

ENV RAILS_ENV="production" \
     BULD_WITHOUT="development test" \
     REDIS_URL="redis://redis:6379/0" \
     RAILS_MASTER_KEY="3acff2d1fc63ca498260a9c0b4ea218b"
     

FROM base as build

# Install build dependencies
RUN apt-get update && \
    apt-get install -y build-essential libpq-dev nodejs && 

# Install gems  
COPY Gemfile Gemfile.lock ./


RUN bundle install && \
    rails assets:precompile && \
    rails db:create db:migrate 

COPY . .

FROM base 


