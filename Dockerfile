FROM python:3.8-slim-buster AS BUILDER

RUN mkdir -p /var/log/nginx && touch /var/log/nginx/access.log && \
    mkdir /mkdocs

WORKDIR /mkdocs

RUN apt-get update && apt-get install -y \
        git && \
    pip3 install \
        mkdocs-material \
        mkdocs-monorepo-plugin

COPY /docs /mkdocs/docs
COPY /mkdocs.yml /mkdocs

RUN mkdocs build

########################
FROM nginx

COPY /nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=BUILDER /mkdocs/site/ /www
