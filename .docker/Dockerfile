FROM ruby:3.1.0-alpine

LABEL maintainer="Alexis Ortega <alexis.oc3@gmail.com>"

ENV RAILS_ENV=production

# ENV RAILS_LOG_TO_STDOUT=true

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

RUN gem install bundler:2.3.3

COPY ["Gemfile", "Gemfile.lock", "/usr/src/"]

RUN bundle install

COPY [".docker/docker-entrypoint.sh", "/usr/bin/"]

RUN chmod +x /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

COPY [".", "/usr/src"]

RUN bundle lock --add-platform aarch64-linux-musl

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
