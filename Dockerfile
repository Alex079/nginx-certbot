FROM nginx

# Install certbot for SSL certificate management
RUN apt update && apt install -y certbot
RUN apt clean && rm -rf /var/lib/apt/lists/*

# Copy the domain management scripts into the container and make them executable
COPY scripts/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*
