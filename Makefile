start:
	make kong-postgres-kafka
kong-postgres:
	docker-compose --profile database up -d
kong-postgres-kafka:
	docker-compose --profile database --profile kafka_cluster up -d
clear:
	docker-compose --profile database --profile kafka_cluster down --volumes
restart:
	make clear
	make kong-postgres-kafka
kong-configure:
	curl -i -X POST http://localhost:8001/consumers -d username=admin
	curl -i -X POST http://localhost:8001/consumers/admin/jwt \ -d algorithm=HS256 \ -d secret=secret \ -d key=key