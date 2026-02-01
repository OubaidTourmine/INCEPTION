# Inception Developer Documentation

## Requirements

Develop on a Linux virtual machine with Docker Engine, the Docker Compose plugin, GNU Make, and network access during image/application setup. The project is launched from the repository root and all container configuration is in `srcs/`.

## Initial configuration

1. Create `srcs/.env` from the required project values. Set `DOMAIN_NAME` to `outourmi.42.fr`, and provide the database name, WordPress users, email addresses, and other site configuration.
2. Create the local files in `secrets/` for database and WordPress credentials.
3. Keep `.env` and `secrets/` private. They are ignored by Git through `.gitignore`.
4. Configure DNS or `/etc/hosts` so `outourmi.42.fr` points to the virtual machine IP.
5. Choose the required host data directory. The subject expects `/home/outourmi/data`; pass it explicitly to Make if the current Linux account has a different home path.

Never place passwords, API keys, or private credentials in a Dockerfile, tracked source file, issue, or README. Docker secrets should be used to inject passwords into containers; ordinary environment variables are appropriate only for non-sensitive configuration.

## Build and launch

```sh
make DATA_DIR=/home/outourmi/data
```

This creates `mariadb` and `wordpress` data directories, then runs Docker Compose with `srcs/docker-compose.yml`. Compose builds the three images from:

- `srcs/requirements/nginx/Dockerfile`
- `srcs/requirements/wordpress/Dockerfile`
- `srcs/requirements/mariadb/Dockerfile`

## Operations

```sh
