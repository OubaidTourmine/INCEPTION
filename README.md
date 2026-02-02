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
