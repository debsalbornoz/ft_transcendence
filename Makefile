# Makefile para orquestrar o ambiente de desenvolvimento do ft_transcendence
#
# Este Makefile segue o estilo do projeto Inception para facilitar a
# administração dos contêineres. Ele utiliza o comando `docker compose` em
# vez de `docker-compose` e cria diretórios para volumes persistentes
# automaticamente.

NAME    = transcendence
COMPOSE = docker compose -f docker-compose.yml -p $(NAME)
DATA_DIR = /home/$(USER)/data/$(NAME)

all: up

# Sobe os serviços em segundo plano, construindo as imagens e criando
# diretórios de dados persistentes se necessário.
up:
	mkdir -p $(DATA_DIR)/mssql
	$(COMPOSE) up -d --build

# Derruba todos os serviços sem remover volumes ou imagens.
down:
	$(COMPOSE) down

# Exibe os logs agregados de todos os serviços.
logs:
	$(COMPOSE) logs -f

# Exibe o status dos contêineres.
ps:
	$(COMPOSE) ps

# Reconstrói todas as imagens sem iniciar os serviços.
build:
	$(COMPOSE) build

# Encerra os serviços e remove os contêineres.
clean: down

# Remove tudo: contêineres, imagens, volumes e diretórios de dados.
fclean:
	$(COMPOSE) down -v --rmi all --remove-orphans
	- sudo rm -rf $(DATA_DIR)

# Remove tudo e sobe novamente os serviços.
re: fclean up

.PHONY: all up down logs ps build clean fclean re