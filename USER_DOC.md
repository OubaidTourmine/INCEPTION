# Inception User Documentation

## Services

The stack provides a WordPress website protected by HTTPS.

- **NGINX** receives browser traffic on port `443` and forwards PHP requests to WordPress.
- **WordPress + PHP-FPM** provides the public website and administration dashboard.
- **MariaDB** stores WordPress users, posts, settings, and other application data.
- **ADMINER** gives a graphical interface for the database.
- **STATIC** creating a static web page without php.

Only NGINX is reachable from outside Docker. MariaDB and PHP-FPM are available only to containers on the private `inception` network.

## Start and stop

Run all commands from the repository root:

```sh
make
make ps
make logs
make stop
make start
make down
```

`make down` removes containers and the Docker network but preserves the website and database data. `make re` removes the images, containers, volumes, and persistent data, then creates a new installation; use it only when a full reset is intended.

## Access the website

use:

- Website: `https://outourmi.42.fr`
- Administration panel: `https://outourmi.42.fr/wp-admin`

## Credentials

Local configuration is stored in:

- `srcs/.env` for non-sensitive settings and WordPress/MariaDB configuration values.
- `secrets/db_root_password.txt` for the MariaDB root password.
- `secrets/db_password.txt` for the WordPress database password.
- `secrets/credentials.txt` for WordPress account credentials.

These files are private machine configuration. They must never be posted, sent, or committed. Change a password by updating its local source, then reset or reconfigure the affected service as documented by the project administrator.

## Check the stack

```sh
make ps
docker compose -f srcs/docker-compose.yml logs --tail=100
curl -kI https://outourmi.42.fr
```

All three services should report `running`. The `curl` command should return an HTTPS response. If the website is unavailable, first check that the domain points to the virtual machine, then inspect the NGINX, WordPress, and MariaDB logs.
