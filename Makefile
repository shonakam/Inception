NAME				:= Inception
UNAME				= $(uname -a)
export DATA_DIR		:= $(CURDIR)/srcs/.docker/data
export LOG_DIR		:= $(CURDIR)/srcs/.docker/logs

$(NAME): up

all: $(NAME)

up:
	@mkdir -p $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
	@mkdir -p $(LOG_DIR)/mariadb $(LOG_DIR)/wordpress $(LOG_DIR)/nginx
	bash srcs/requirements/tools/certs.sh
	docker-compose -f srcs/docker-compose.yml up --build -d
	bash srcs/requirements/tools/hosts.sh create

down:
	docker-compose -f srcs/docker-compose.yml down
	bash srcs/requirements/tools/hosts.sh delete

clean: down
	@rm -rf $(DATA_DIR)
	@rm -rf $(LOG_DIR)

fclean:
	docker-compose -f srcs/docker-compose.yml down --rmi local -v
	docker system prune -af
	@rm -rf $(DATA_DIR)
	@rm -rf $(LOG_DIR)
	bash srcs/requirements/tools/hosts.sh delete

ps:
	@docker-compose -f srcs/docker-compose.yml ps

re: fclean up

.PHONY: all up down clean fclean ps re

# == DEBUG ==
debug_mariadb_sql:
	@docker exec -it mariadb mariadb -u root

debug_mariadb:
	@docker-compose -f srcs/docker-compose.yml exec mariadb sh

debug_nginx:
	@docker-compose -f srcs/docker-compose.yml exec nginx sh

debug_wordpress:
	@docker-compose -f srcs/docker-compose.yml exec wordpress sh

logs_wordpress:
	@docker-compose -f srcs/docker-compose.yml logs wordpress
