FROM ruby:3.1.0-alpine

LABEL maintainer="Alexis Ortega <alexis.oc3@gmail.com>"

ARG RAILS_ENVIRONMENT=production

ENV RAILS_ENV=$RAILS_ENVIRONMENT

ENV RAILS_LOG_TO_STDOUT=true

RUN apk update \
    # to ensure certain gems can be compiled
    && apk add build-base \
    && apk add less \
    && apk add tree \
    && apk add vim \
    && apk add gcompat \
    # && apk add sqlite \
    # && apk add sqlite-dev \
    && apk add mariadb-dev \
    && apk add tzdata

WORKDIR /usr/src

RUN gem install bundler:2.4.13

RUN alias bi="bundle install"

COPY ["Gemfile", "Gemfile.lock", "/usr/src/"]

RUN bundle install

COPY [".docker/docker-entrypoint.sh", "/usr/bin/"]

RUN chmod +x /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

COPY [".", "/usr/src"]

RUN bundle lock --add-platform aarch64-linux-musl

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
