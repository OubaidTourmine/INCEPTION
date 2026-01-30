NAME := inception

COMPOSE_FILE := srcs/docker-compose.yml
DATA_DIR ?= /home/outourmi/data
COMPOSE := DATA_DIR="$(DATA_DIR)" docker compose -f $(COMPOSE_FILE)

DATA_PATHS := $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress

.PHONY: all up build down start stop restart logs ps config clean fclean re

all: up

$(DATA_PATHS):
	mkdir -p $@

up: $(DATA_PATHS)
	$(COMPOSE) up -d --build

build:
	$(COMPOSE) build

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

restart:
	$(COMPOSE) restart

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

config:
	$(COMPOSE) config

clean:
	$(COMPOSE) down --remove-orphans

fclean:
	$(COMPOSE) down --rmi all --volumes --remove-orphans
	@test -n "$(DATA_DIR)" && test "$(DATA_DIR)" != "/"
	rm -rf "$(DATA_DIR)/mariadb" "$(DATA_DIR)/wordpress"

re: fclean all
