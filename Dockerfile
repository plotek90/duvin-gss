FROM ruby:2

RUN apt-get update -y \
    && apt-get -y --no-install-recommends install make gcc \
    && apt-get -y clean autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/  \
      /var/lib/dpkg/  \
      /var/lib/cache/  \
      /var/lib/log/ \
    && mkdir "/app"

RUN gem install bundler:2.1.4

WORKDIR "/app"

COPY Gemfile /app
COPY Gemfile.lock /app

RUN bundle install

ENTRYPOINT ["bundle", "exec", "jekyll"]
CMD ["serve", "--config=_config_dev.yml"]