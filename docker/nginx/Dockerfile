# nginx/Dockerfile
FROM nginx:alpine

RUN apk --update add supervisor

ENV GROUP_ID=1000 \
    USER_ID=1000
ENV USER=docker
RUN addgroup "docker"
RUN adduser \
    --disabled-password \
    --gecos "" \
    --ingroup "$USER" \
    --no-create-home \
    --uid "$USER_ID" \
    "$USER"

WORKDIR /main

CMD ["nginx"]

EXPOSE 80