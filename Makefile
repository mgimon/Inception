NAME=inception

all: up

up:
	docker-compose -f srcs/docker-compose.yml up -d --build

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	@docker rmi $$(docker images -q) || true

fclean: clean
	@docker volume rm srcs_mariadb_vol
	@docker volume rm srcs_wordpressfiles_vol
	@docker stop $(docker ps -qa)
	@docker rm $(docker ps -qa)

re: fclean all
