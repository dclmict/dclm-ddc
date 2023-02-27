up:
	docker compose -f ./src/frontend/docker-compose.yml --env-file ./src/frontend/.env up --detach
build:
	docker compose -f ./src/frontend/docker-compose.yml --env-file ./src/frontend/.env up --detach --build
down:
	docker compose -f ./src/frontend/docker-compose.yml --env-file ./src/frontend/.env down
start:
	docker compose -f ./src/frontend/docker-compose.yml --env-file ./src/frontend/.env start
stop:
	docker compose -f ./src/frontend/docker-compose.yml --env-file ./src/frontend/.env stop
restart:
	docker compose -f ./src/frontend/docker-compose.yml --env-file ./src/frontend/.env.dev restart
destroy:
	docker compose -f ./src/frontend/docker-compose.yml --env-file ./src/frontend/.env down --volumes
shell:
	docker compose -f ./src/frontend/docker-compose.yml --env-file ./src/frontend/.env exec -it ddc-src sh
log:
	docker compose -f ./src/frontend/docker-compose.yml --env-file ./src/frontend/.env logs -f ddc-src