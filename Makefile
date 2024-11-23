DATA_DIR=${HOME}/data
WORDPRESS_VOLUME_DIR=${DATA_DIR}/wordpress
DB_VOLUME_DIR=${DATA_DIR}/db

all: up

build:
	docker compose -f srcs/docker-compose.yml build

up: ${WORDPRESS_VOLUME_DIR} ${DB_VOLUME_DIR}
	docker compose -f srcs/docker-compose.yml up -d

stop:
	docker compose -f srcs/docker-compose.yml stop

start:
	docker compose -f srcs/docker-compose.yml start

down:
	docker compose -f srcs/docker-compose.yml down

clean:
	-docker builder prune -a -f

fclean: down clean
	-docker volume rm wordpress
	-docker volume rm db
	-docker image rm nginx
	-docker image rm mariadb
	-rm -rf ${DATA_DIR}

re: fclean all

${WORDPRESS_VOLUME_DIR} ${DB_VOLUME_DIR}:
	mkdir -p $@
