FROM nginx

# Install certbot for SSL certificate management
RUN apt update && apt install -y --no-install-recommends certbot cron
RUN apt clean && rm -rf /var/lib/apt/lists/*
RUN rm /etc/cron.daily/apt-compat /etc/cron.daily/dpkg

#Enable stream module in nginx and include the stream configuration directory
RUN cat >> /etc/nginx/nginx.conf <<EOF

stream {
    include /etc/nginx/conf.d/streams/*.conf;
}
EOF

RUN sed -i '/^exec/i\service cron start' /docker-entrypoint.sh

# Copy the domain management scripts into the container and make them executable
COPY scripts/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*
