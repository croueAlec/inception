# Colors
DEFAULT    = \033[0m
BLACK    = \033[0;30m
RED        = \033[0;31m
GREEN    = \033[0;32m
YELLOW    = \033[0;33m
BLUE    = \033[0;34m
PURPLE    = \033[0;35m
CYAN    = \033[0;36m
BWHITE    = \033[1;37m
BBLUE    = \033[1;34m

# Variables
VOLUMES_PATH=/home/acroue/data
COMPOSE_FILE=srcs/docker-compose.yml

# Rules
all: isenv volumes build up

isenv:
	@if [ -f srcs/.env ]; then \
		true; \
	else \
		echo "$(RED)Missing .env file$(DEFAULT)"; \
		exit 1; \
	fi

build:
	@echo "$(PURPLE)Building$(DEFAULT)"
	docker compose -f $(COMPOSE_FILE) build

up:
	@echo "$(GREEN)Running$(DEFAULT)"
	docker compose -f $(COMPOSE_FILE) up -d

down:
	@echo "$(BLUE)Down (removing containers)$(DEFAULT)"
	docker compose -f $(COMPOSE_FILE) down

reup: down up

start:
	@echo "$(YELLOW)Starting$(DEFAULT)"
	docker compose -f $(COMPOSE_FILE) start

stop:
	@echo "$(CYAN)Stopping$(DEFAULT)"
	docker compose -f $(COMPOSE_FILE) stop

clean:
	@echo "$(BLUE)Down (removing containers $(BBLUE), volumes and images$(BLUE))$(DEFAULT)"
	docker compose -f $(COMPOSE_FILE) down --volumes --rmi all

prune: stop rmvolumes
	@echo "$(RED)Removing everything$(DEFAULT)"
	docker system prune -a

#	Infos
logs:
	docker compose -f $(COMPOSE_FILE) logs

ls:
	docker compose -f $(COMPOSE_FILE) ps -a

network:
	docker inspect inception | grep Name

#	Volumes
rmvolumes:
	@echo "$(RED)Removing volumes$(DEFAULT)"
	sudo rm -rf $(VOLUMES_PATH)/mariadb/* $(VOLUMES_PATH)/wordpress/*

volumes:
	@echo "$(GREEN)Creating volumes$(DEFAULT)"
	@mkdir -p $(VOLUMES_PATH)/mariadb
	@mkdir -p $(VOLUMES_PATH)/wordpress

loadbackup: stop
	@echo "$(GREEN)Loading backup of website$(DEFAULT)"
	@sudo cp -R /home/acroue/Backup/* /home/acroue/data/.
	@make start