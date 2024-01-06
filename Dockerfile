# syntax=docker/dockerfile:1

FROM ruby:3.1.4

RUN groupadd -g 1000 appgroup && \
    useradd -u 1000 -m appuser -g appgroup

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
WORKDIR /app
COPY Gemfile* config.ru ./
RUN gem install bundler && bundle install
COPY app.rb .

RUN chown -R appuser:appgroup /app

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]

