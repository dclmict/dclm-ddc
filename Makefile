# https://makefiletutorial.com/

SHELL := /bin/bash

# copy .env file based on environment
SRC := $(shell os=$$(uname -s); \
	if [ "$$os" = "Linux" ]; then \
		cp ./ops/.env.prod ./src/.env; \
	elif [ "$$os" = "Darwin" ]; then \
		cp ./ops/.env.dev ./src/.env; \
	else \
		exit 1; \
	fi)

# load .env file
include ./src/.env

git:
	@if git status --porcelain | grep -q '^U'; then \
		make commit-1; \
		make git-push; \
	elif git status --porcelain | grep -qE '[^ADMR]'; then \
		make commit-2; \
		make git-push; \
	elif [ -z "$$(git status --porcelain)" ]; then \
		make git-push; \
	else \
		echo -e "\033[31mUnknown status. Aborting...\033[0m"; \
		exit 0; \
	fi

commit-1:
	@echo -e "\033[31mUntracked files found::\033[0m \033[32mPlease enter commit message:\033[0m"; \
	read -r msg1; \
	git add -A; \
	git commit -m "$$msg1"; \

commit-2:
	@echo -e "\033[31mModified files found...\033[0m \033[32mPlease enter commit message:\033[0m"; \
	read -r msg2; \
	git commit -am "$$msg2"

git-push:
	@read -p "Do you want to push your commit to GitHub? (yes|no): " choice; \
	case "$$choice" in \
		yes|Y|y) \
			echo -e "\033[32mPushing commit to GitHub...:\033[0m"; \
			gh secret set -f ops/.env.prod; \
			git push; \
			;; \
		no|N|n) \
			echo -e "\033[32m Nothing to be done. Thank you...:\033[0m"; \
			exit 0; \
			;; \
		*) \
			echo -e "\033[32m No choice. Exiting script...:\033[0m"; \
			exit 1; \
			;; \
	esac

image:
	@if docker images | grep -q $(DIN); then \
		echo -e "\033[31mRemoving all dangling images\033[0m"; \
		echo y | docker image prune --filter="dangling=true"; \
		echo "Building \033[31m$(DIN):$(DIV)\033[0m image"; \
		docker build -t $(DIN):$(DIV) .; \
		docker images | grep $(DIN); \
	else \
		echo -e "\033[32mBuilding $(DIN):$(DIV) image\033[0m"; \
		docker build -t $(DIN):$(DIV) .; \
		docker images | grep $(DIN); \
	fi

image-push:
	@echo ${DLP} | docker login -u opeoniye --password-stdin
	@docker push $(DIN):$(DIV)

up:
	@if [ "$$(uname -s)" = "Linux" ]; then \
		if [ -f ops/.env.prod ]; then \
			echo -e "\033[31mStarting container in prod environment...\033[0m"; \
			cp $(EP) $(ENF) 2>/dev/null || :; \
			docker pull $(DIN):$(DIV); \
			docker compose -f $(DCF) --env-file $(EF) up -d; \
		else \
			echo -e "\033[31menv file for prod missing.\033[0m"; \
			exit 1; \
		fi; \
	elif [ "$$(uname -s)" = "Darwin" ]; then \
		if [ -f ops/.env.prod ]; then \
			echo -e "\033[31mStarting container in dev environment...\033[0m"; \
			cp $(ED) $(ENF) 2>/dev/null || :; \
			docker compose -f $(DCF) --env-file $(EF) up -d; \
		else \
			echo -e "\033[31menv file for dev missing.\033[0m"; \
			exit 1; \
		fi; \
	else \
		echo -e "Unsupported operating system."; \
		exit 1; \
	fi

down:
	@docker compose -f $(DCF) --env-file $(EF) down

start:
	@docker compose -f $(DCF) --env-file $(EF) start

restart:
	@docker compose -f $(DCF) --env-file $(EF) restart

stop:
	@docker compose -f $(DCF) --env-file $(EF) stop

sh:
	@docker compose -f $(DCF) --env-file $(EF) exec -it $(CN) bash

ps:
	@docker compose -f $(DCF) ps

stats:
	@docker compose -f $(DCF) top

log:
	@docker compose -f $(DCF) --env-file $(EF) logs -f $(CN)

run:
	@echo -e "\033[31mEnter command to run inside container: \033[0m"; \
	read -r cmd; \
	docker compose -f $(DCF) exec $(CN) bash -c "$$cmd"

new:
	@git restore .
	@git pull