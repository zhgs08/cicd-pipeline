FROM node:10.15.3
WORKDIR /opt
ADD . /opt
RUN npm install
ENTRYPOINT npm run start
