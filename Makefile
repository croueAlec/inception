COMPOSE_FILE=docker-compose.yml

all: build up

build:
	docker compose -f $(COMPOSE_FILE) build

up:
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

restart: down up

clean:
	docker compose -f $(COMPOSE_FILE) down --volumes --rmi all

stop:
	docker compose -f $(COMPOSE_FILE) stop

prune: stop
	docker system prune -a
	sudo rm -rf /var/db/mariadb/* /var/db/wordpress/*

logs:
	docker compose -f $(COMPOSE_FILE) logs

ls:
	docker compose -f $(COMPOSE_FILE) ps -a