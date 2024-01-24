kong:
	docker-compose up -d
kong-postgres:
	docker-compose --profile database up -d
kong-postgres-kafka:
	docker-compose --profile database --profile kafka_cluster up -d
clear:
	docker-compose --profile database --profile kafka_cluster down --volumes