This project has been created as part of the 42 curriculum by outourmi

# Inception

## Description

Inception is a small web infrastructure deployed with Docker Compose. It runs three independent containers on a private Docker network:

- **NGINX** is the only public entry point. It serves WordPress files and terminates HTTPS connections on port `443` with TLS 1.2 or TLS 1.3.
- **WordPress + PHP-FPM** executes the application and communicates with MariaDB through FastCGI and the internal Docker network.
- **MariaDB** stores the WordPress database and is not exposed to the host.
- **ADMINER** gives a graphical interface for the database.
- **STATIC** creating a static web page without php.

Each image is built from its own Dockerfile. Debian Bookworm is the base operating system; Docker Compose builds and connects the services. Two Docker named volumes persist the database and website files under the host data directory.


## Instructions

- Linux virtual machine with Docker Engine and the Docker Compose plugin.
- A local DNS or `/etc/hosts` entry mapping `outourmi.42.fr` to the virtual machine's IP address.
- Local configuration files in `srcs/.env` and `secrets/`. These files contain machine-specific values and must not be committed.

### run the project

From the repository root:

```sh
make
```

The Makefile creates the persistent data directories and builds then starts the stack. By default data is placed in `$HOME/data`. To use the subject's required path explicitly, run:

```sh
make DATA_DIR=/home/outourmi/data
```

Open `https://outourmi.42.fr` in a browser. The WordPress administration page is available at `https://outourmi.42.fr/wp-admin`.

Useful commands:

```sh
make ps       # show service status
make logs     # follow container logs
make stop     # stop containers without removing them
make down     # remove containers and network
make re       # rebuild from scratch; removes persistent data
```

## Resources

- [Docker documentation](https://docs.docker.com/)
- [Docker Compose documentation](https://docs.docker.com/compose/)
- [NGINX documentation](https://nginx.org/en/docs/)
- [WordPress documentation](https://wordpress.org/documentation/)
- [MariaDB documentation](https://mariadb.com/kb/en/documentation/)
- [OWASP Docker Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)

### AI usage

AI was used to help review the subject requirements and draft the documentation structure. All configuration, commands, and technical explanations are reviewed and must be understood and tested by the project author before submission.

## Virtual Machines vs Docker containers

### Container vs Virtual Machine

Virtual Machine:
- Has full guest OS and its own kernel
- Strong isolation but heavier resource overhead

Container:
- Shares host kernel
- Isolated process/filesystem/network view
- Faster startup, lighter footprint

Inception uses containers because it needs multiple isolated services with low overhead.

### Secrets vs Environment Variables

Environment variables are easy to inject but can leak via process inspection or logs. Docker secrets are mounted as files and reduce exposure. This project uses secrets for database credentials and env vars for non-sensitive configuration.

### Docker Network vs Host Network

A Docker network provides isolated service-to-service communication without exposing internal ports on the host. Host networking removes isolation and is forbidden by the subject. This project uses a dedicated bridge network.

### Docker Volumes vs Bind Mounts

Bind mounts map arbitrary host paths directly into containers, which can be flexible but less portable. Named volumes are managed by Docker and are more predictable. This project uses named volumes mapped to `/home/<login>/data` as required.
