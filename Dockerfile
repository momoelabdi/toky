# syntax = docker/dockerfile:1.0-experimental

# Ruby version to use
FROM ruby:3.2.0

# Install dependencies
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y postgresql \
                       build-essential \
                       libpq-dev \
                       postgresql-client && \
    apt-get clean

# RUN apt-get update  && apt-get dist-upgrade
# Create a new user for running the app
RUN useradd -m -s /bin/bash rails
USER root

RUN mkdir /app

WORKDIR /app

# Copy the app folder
COPY . toky/app

# Copy the database configuration
COPY config/database.yml config/database.yml
# Copy the Gemfile and install the gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install
RUN service postgresql start
RUN rails assets:precompile
RUN rails db:create
RUN rails db:migrate

# Copy the rest of the app
COPY . .

# Copy the configuration files
# COPY config/redis.yml config/redis.yml

# Set the environment variables
# ENV RAILS_ENV="production" \
#     BUILD_WITHOUT="development test" \
#     RAILS_MASTER_KEY="3acff2d1fc63ca498260a9c0b4ea218b" \
#     REDIS_URL="redis://redis:6379/0"


# Expose port 3000
EXPOSE 3000

# Start the server
CMD ["rails", "server", "-b", "127.0.0.1"]

