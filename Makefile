# Load .env if present so make targets see the same settings as compose
-include .env
export

.PHONY: up down ps logs psql reset-db

up:  ## Start containers and wait until healthy
	docker compose up -d --wait

down:  ## Stop containers (data is kept)
	docker compose down

ps:  ## Show container status
	docker compose ps

logs:  ## Follow container logs
	docker compose logs -f

psql:  ## Open a psql shell inside the Postgres container
	docker compose exec postgres psql -U $(POSTGRES_USER) -d $(POSTGRES_DB)

reset-db:  ## DELETE all Postgres data and start fresh
	@read -p "This deletes all Postgres data. Type yes to continue: " ans && [ "$$ans" = yes ]
	docker compose down -v
	docker compose up -d --wait
