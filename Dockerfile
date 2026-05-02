FROM nginx:latest
USER root
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*
COPY index.html /usr/share/nginx/html/index.html
