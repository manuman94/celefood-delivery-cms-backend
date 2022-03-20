# @(#) Dockerfile
FROM node:14-alpine

RUN pwd
# Create app directory
RUN mkdir -p /usr/src/app && chown node:node /usr/src/app
RUN pwd
WORKDIR /usr/src/app
RUN pwd

# Install app dependencies
COPY . .
RUN npm install

RUN addgroup -S celebrand && adduser -S celebrand -G celebrand    

# Bundle app source
RUN npm run build-ci
RUN chown -R celebrand:celebrand /usr/src/app && ls -la

USER celebrand
WORKDIR /usr/src/app

ADD .envprod .env

EXPOSE 8080
ENTRYPOINT [ "npm", "run", "start:prod" ]