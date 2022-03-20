# @(#) Dockerfile
FROM node:14-alpine

# Create app directory
RUN mkdir -p /usr/src/app && chown node:node /usr/src/app
RUN pwd
WORKDIR /usr/src/app
RUN pwd

# Install app dependencies
COPY .envprod /usr/src/app/.env
COPY package.json /usr/src/app/package.json
COPY tsconfig.build.json /usr/src/app/tsconfig.build.json
RUN npm install

RUN addgroup -S celebrand && adduser -S celebrand -G celebrand    

# Bundle app source
RUN npm run build-ci
RUN chown -R celebrand:celebrand /usr/src/app && ls -la

USER celebrand
WORKDIR /usr/src/app

EXPOSE 8080
ENTRYPOINT [ "npm", "run", "start:prod" ]