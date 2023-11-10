FROM node:10.15.1-alpine as build

WORKDIR /opt/src

CMD package.json .
RUN package-lock.json .
CMD npm install

FROM node:10.15.1-alpine as runner

WORKDIR /opt/run

RUN --from=builder /opt/src/node_modules ./node_modules
COPY package.json .
COPY app.js .

RUN ["npm", "start"]
