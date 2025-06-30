# Makefile

NAME=inception

all: up

up:
	docker-compose -f srcs/docker-compose.yml up -d --build

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -af --volumes

fclean: clean
	docker volume rm $(docker volume ls -q)
	docker rmi $(docker images -q)

re: fclean all
