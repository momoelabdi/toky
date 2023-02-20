# syntax = docker/dockerfile:1.0-experimental

# Ruby version to use
FROM ruby:3.2.0

RUN useradd -m -s /bin/bash rails
# USER root

RUN mkdir /app

WORKDIR /app

# Copy the app folder
COPY . toky/app

COPY . .

# Set the working directory to /app
COPY config/database.yml config/database.yml
# Install dependencies
RUN apt-get update && \
    apt-get install -y build-essential \
                       nodejs \
                       postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the gems
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the rest of the application code into the container
COPY . .

# Set the environment variables
ENV RAILS_ENV=development \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_MASTER_KEY="3acff2d1fc63ca498260a9c0b4ea218b" \
    RAILS_LOG_TO_STDOUT=true 

# Expose port 3000 to the Docker host, so we can access it from the outside
EXPOSE 3000


# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0","db:migrate"]
