# Nginx + Certbot container

This is an attempt to make nginx and certbot coexist in one container.

The `nginx` is the primary application and an entrypoint. The `certbot` is managed by scripts and schedules itself with cron for certificates renewal.

## Container management

```bash
docker compose up
docker compose down
```

- the volume `volumes/letsencrypt` will contain the output files of `certbot`
- the volume `volumes/nginx-config` will contain the configuration files for `nginx`
- the container ports 80 and 443 will be exposed
- certbot will listen on port 80 only on demand in order to pass `HTTP-01` challenge
- nginx will listen on port 443

## Domain management

```bash
docker compose exec nginx-certbot domain-add <domain-name> <admin-email>
docker compose exec nginx-certbot domain-remove <domain-name>
```

- a newly obtained certificate will be managed by `certbot`
- a new server block will be added into `nginx` configuration with HTTP 404 stub response
