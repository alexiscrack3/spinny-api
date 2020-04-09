FROM mongo-express:latest

RUN apk update && apk --no-cache --update add vim

# COPY ["package.json", "package-lock.json", "/usr/src/"]
COPY [".", "/usr/src/"]

WORKDIR /usr/src

RUN npm install

EXPOSE 3000

CMD ["npm", "run", "debug"]
