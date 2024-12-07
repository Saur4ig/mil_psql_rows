.PHONY: run, build, down

build:
	docker build -t sender .

run:
	docker-compose up -d db
	# Wait until the database is fully ready
	@echo "Waiting for the database to be ready..."
	@until docker exec $$(docker-compose ps -q db) pg_isready -h db -U admin; do sleep 1; done
	docker-compose up -d sender

down:
	docker-compose down
