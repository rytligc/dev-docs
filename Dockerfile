FROM nginx

RUN mkdir -p /var/log/nginx && touch /var/log/nginx/access.log && \
    mkdir /mkdocs && \
    apt-get update && apt-get install -y \
        python3 \
        python3-dev \
        python3-pip && \
    pip3 install mkdocs && \
    pip3 install mkdocs-material && \
    pip3 install mkdocs-monorepo-plugin && \
    pip3 install mkdocs-multirepo
    
WORKDIR /mkdocs

COPY /nginx.conf /etc/nginx/conf.d/default.conf
COPY /mkdocs.yml /mkdocs
COPY /docs /mkdocs/docs
RUN mkdocs build && mv site/ /www