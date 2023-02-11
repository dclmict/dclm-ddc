up:
	docker compose -f ./app/frontend/docker-compose.yml --env-file ./app/frontend/.env up --detach
build:
	docker compose -f ./app/frontend/docker-compose.yml --env-file ./app/frontend/.env up --detach --build
down:
	docker compose -f ./app/frontend/docker-compose.yml --env-file ./app/frontend/.env down
start:
	docker compose -f ./app/frontend/docker-compose.yml --env-file ./app/frontend/.env start
stop:
	docker compose -f ./app/frontend/docker-compose.yml --env-file ./app/frontend/.env stop
restart:
	docker compose -f ./app/frontend/docker-compose.yml --env-file ./app/frontend/.env.dev restart
destroy:
	docker compose -f ./app/frontend/docker-compose.yml --env-file ./app/frontend/.env down --volumes
shell:
	docker compose -f ./app/frontend/docker-compose.yml --env-file ./app/frontend/.env exec -it ddc-app sh
log:
	docker compose -f ./app/frontend/docker-compose.yml --env-file ./app/frontend/.env logs -f ddc-app