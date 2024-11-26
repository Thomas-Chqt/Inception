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

rmdata:
	@if docker volume inspect wordpress >/dev/null 2>/dev/null && docker volume inspect db >/dev/null 2>/dev/null; then \
		echo "run --rm -it -v wordpress:/wp -v db:/db debian bash -c 'rm -rf /wp/* /db/*'"; \
		docker run --rm -it -v wordpress:/wp -v db:/db debian bash -c 'rm -rf /wp/* /db/*'; \
	elif docker volume inspect wordpress >/dev/null 2>/dev/null; then \
		echo "run --rm -it -v wordpress:/wp debian bash -c 'rm -rf /wp/*'"; \
		docker run --rm -it -v wordpress:/wp debian bash -c 'rm -rf /wp/*'; \
	elif docker volume inspect db >/dev/null 2>/dev/null; then \
		echo "run --rm -it -v db:/db debian bash -c 'rm -rf /db/*'"; \
		docker run --rm -it -v db:/db debian bash -c 'rm -rf /db/*'; \
    fi

fclean: down clean rmdata
	-docker volume rm wordpress
	-docker volume rm db
	-docker image rm -f nginx
	-docker image rm -f mariadb
	-rm -rf ${DATA_DIR}

re: fclean all

${WORDPRESS_VOLUME_DIR} ${DB_VOLUME_DIR}:
	mkdir -p $@