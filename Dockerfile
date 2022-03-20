# @(#) Dockerfile
# usage : $ docker build -t edicom/base -t latest .
FROM node:14-alpine

# Create app directory
RUN mkdir -p /usr/src/app && chown node:node /usr/src/app
RUN pwd
WORKDIR /usr/src/app
RUN pwd

# Install app dependencies
COPY .envprod /usr/src/app/.env
COPY package.json /usr/src/app/package.json
RUN npm install

RUN addgroup -S edicom && adduser -S edicom -G edicom    

# Bundle app source
COPY /dist /usr/src/app/dist
RUN chown -R edicom:edicom /usr/src/app && ls -la

USER edicom
WORKDIR /usr/src/app

EXPOSE 8080
ENTRYPOINT [ "npm", "run", "prod" ]