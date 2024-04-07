start:
	make kong-postgres-kafka
kong-postgres:
	docker compose --profile database up -d
kong-postgres-kafka:
	docker compose --profile database --profile kafka_cluster up -d
clear:
	docker compose --profile database --profile kafka_cluster down --volumes
restart:
	make clear
	make kong-postgres-kafka
add-centrifugo:
	curl  -X POST \
  '127.0.0.1:8001/services/' \
  --header 'Accept: */*' \
  --form 'name="centrifugo"' \
  --form 'url="http://centrifugo:8000"'

	curl  -X POST \
  '127.0.0.1:8001/services/centrifugo/routes' \
  --header 'Accept: */*' \
  --form 'paths[]="/centrifugo"'