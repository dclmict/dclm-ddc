# Dockerfile for HTML app

FROM nginx:alpine3.19 AS runner
WORKDIR /app
ENV TZ=Africa/Lagos
RUN apk --no-cache add tzdata curl wget && date
COPY ./src ./
COPY ./ops/ngx/app.conf /etc/nginx/conf.d/default.conf

EXPOSE 3000
CMD ["nginx","-g","daemon off;"]
