# Base image with Ruby 4.0.1
FROM ruby:4.0.1-slim

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  curl \
  git \
  nodejs \
  postgresql-client \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install bundler
RUN gem install bundler

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' && bundle install

# Copy application code
COPY . .

# Precompile bootsnap
RUN bundle exec bootsnap precompile --gemfile app/ lib/

# Precompile assets
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# Run migrations and start server
EXPOSE 3000
CMD bundle exec rails db:migrate && bundle exec rails db:seed && bundle exec puma -C config/puma.rb