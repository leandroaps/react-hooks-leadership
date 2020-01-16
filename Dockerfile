FROM node:latest as builder
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
RUN yarn
COPY . ./
RUN yarn build

FROM nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /usr/src/app/build /var/www

EXPOSE 80
ENTRYPOINT ["nginx","-g","daemon off;"]
