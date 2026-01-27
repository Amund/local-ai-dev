# NOTE: les arguments précédés par des moins (-y, --version) seront capturés par make et ne seront pas disponibles pour les commandes
#
# On peut les forcer en ajoutant un argument "--" :
# Tout ce qui suit cet argument spécial n'est pas capturé par make, et sera donc correctement envoyé vers les commandes
#
# La notation générique permet de complètement contourner ce problème : make [action] -- [arguments]
# exemples :
#   make drush -- cim -y
#   make npm -- install malib --save-dev


## GESTION DES CONTAINERS
.PHONY: up down restart update shell logs

up: # Start up containers
	@docker compose up -d --remove-orphans
down: # Stop containers
	@docker compose down -v
restart: # Stop containers
	@docker compose down -v && docker compose up -d --remove-orphans
update: # Update containers with last image
	@docker compose down -v --rmi all && docker compose up -d --remove-orphans
shell:
	@docker compose exec app /bin/bash
logs:
	@docker compose logs -f


## OUTILS COURANTS
.PHONY: download-models copy-agent easy-dataset

sync:
	@rsync -cavz ./assistants/ ~/.continue/assistants --delete && echo Continue config synced

remove-index:
	@rm -rf ~/.continue/index && echo Continue indexes removed

easy-dataset:
	@docker run -d -p 1717:1717 --name easy-dataset -v ./dataset/local-db:/app/local-db ghcr.io/conardli/easy-dataset
# 	@docker run -d -p 1717:1717 -v ./dataset/local-db:/app/local-db -v ./dataset/prisma:/app/prisma --name easy-dataset --user 1000:1000 ghcr.io/conardli/easy-dataset

%:
	@:
