.PHONY: build run stop clean logs help

export ENV ?= development

ifeq ($(ENV), production)
	export FRONTEND_ENV_FILE := ./frontend/.env.production
	export BACKEND_ENV_FILE := ./backend/.env.production
	export DATABASE_ENV_FILE := ./database/.env.production
else
	export FRONTEND_ENV_FILE := ./frontend/.env.development
	export BACKEND_ENV_FILE := ./backend/.env.development
	export DATABASE_ENV_FILE := ./database/.env.development
endif

# Color codes
GREEN := \033[0;32m
YELLOW := \033[0;33m
RESET := \033[0m

help:
	@echo "${GREEN}Available targets:${RESET}"
	@echo "  ${YELLOW}make build${RESET}       - Build Docker images"
	@echo "  ${YELLOW}make run${RESET}         - Build and run Docker containers in the background"
	@echo "                    (use '${YELLOW}make run ENV=production${RESET}' for production)"
	@echo "  ${YELLOW}make stop${RESET}        - Stop and remove Docker containers"
	@echo "  ${YELLOW}make clean${RESET}       - Stop and remove Docker containers, as well as clean up unused images"
	@echo "  ${YELLOW}make logs${RESET}        - View logs of running containers"
	@echo "  ${YELLOW}make help${RESET}        - Display this help message"
	@echo ""
	@echo "${GREEN}Environment variables:${RESET}"
	@echo "  ${YELLOW}ENV${RESET}              - Set to 'production' for production environment (default is 'development')"

build:
	docker-compose build

run: build
	docker-compose up -d

stop:
	docker-compose down

clean:
	docker-compose down --volumes --remove-orphans
	docker image prune -f

logs:
	docker-compose logs -f
