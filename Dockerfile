FROM mongo-express:latest

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main' >> /etc/apk/repositories

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories

RUN apk update && apk --no-cache --update add mongodb

RUN mkdir -p /data/db

# COPY ["package.json", "package-lock.json", "/usr/src/"]
COPY [".", "/usr/src/"]

WORKDIR /usr/src

RUN npm install

# RUN mongod --fork --syslog
# ENTRYPOINT mongod --fork --syslog

EXPOSE 3000

CMD ["npm", "run", "debug"]
