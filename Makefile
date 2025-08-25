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
.PHONY: up down shell shell-root logs

up: # Start up containers
	@docker compose up -d --remove-orphans
down: # Stop containers
	@docker compose down -v
shell:
	@docker compose exec app /bin/bash
shell-root:
	@docker compose exec -u 0:0 app /bin/bash
logs:
	@docker compose logs -f


## OUTILS COURANTS
.PHONY: download-models copy-agent

download-models:
	@wget -qc --show-progress https://huggingface.co/unsloth/Qwen3-30B-A3B-Thinking-2507-GGUF/resolve/main/Qwen3-30B-A3B-Thinking-2507-UD-Q4_K_XL.gguf?download=true -O ./models/unsloth--Qwen3-30B-A3B-Thinking-2507-GGUF
	@wget -qc --show-progress https://huggingface.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF/resolve/main/Qwen3-Coder-30B-A3B-Instruct-UD-Q4_K_XL.gguf?download=true -O ./models/unsloth--Qwen3-Coder-30B-A3B-Instruct-GGUF
	@wget -qc --show-progress https://huggingface.co/unsloth/Qwen3-4B-Instruct-2507-GGUF/resolve/main/Qwen3-4B-Instruct-2507-Q4_K_M.gguf?download=true -O ./models/unsloth--Qwen3-4B-Instruct-2507-GGUF
	@wget -qc --show-progress https://huggingface.co/Qwen/Qwen3-Embedding-0.6B/resolve/main/model.safetensors?download=true -O ./models/Qwen--Qwen3-Embedding-0.6B
	@wget -qc --show-progress https://huggingface.co/Qwen/Qwen3-Reranker-0.6B/resolve/main/model.safetensors?download=true -O ./models/Qwen--Qwen3-Reranker-0.6B

copy-agent:
	@install -D -m 664 qwen-local.yaml ~/.continue/assistants/qwen-local.yaml && echo Agent copied 
%:
	@:
