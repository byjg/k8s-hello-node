FROM node:10.15.1-alpine as builder

WORKDIR /opt/src

COPY package.json .
COPY package-lock.json .
RUN npm install

FROM node:10.15.1-alpine as runner

WORKDIR /opt/run

COPY --from=builder /opt/src/node_modules ./node_modules
COPY package.json .
COPY app.js .

CMD ["npm", "start"]
