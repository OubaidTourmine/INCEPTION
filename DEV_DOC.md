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
make build                    # build images only
make up                       # build and start services
make ps                       # list service state
make logs                     # follow logs
make config                   # render Compose configuration
make stop                     # stop services
make start                    # start existing services
make down                     # remove containers and network
make clean                    # Compose cleanup without deleting data
make fclean                   # delete images, volumes, and persistent data
make re                       # fclean followed by a new build
```

For targeted debugging:

```sh
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml exec wordpress sh
docker compose -f srcs/docker-compose.yml exec mariadb mariadb -u root -p
```

## Persistence

The Compose file defines named volumes:

- `mariadb` is mounted at `/var/lib/mysql` and contains MariaDB data.
- `wordpress` is mounted at `/var/www/wordpress` and contains WordPress files.

The Makefile supplies `DATA_DIR`; by default it is `$HOME/data`. The local Docker volume driver maps the named-volume data to `$DATA_DIR/mariadb` and `$DATA_DIR/wordpress` on the host. This lets data survive container recreation and `make down`.

`make fclean` and `make re` deliberately delete both persistent directories. Back them up before running either command when the installation contains data you need.
