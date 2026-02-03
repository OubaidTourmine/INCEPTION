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
