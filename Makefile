pullimage:
	docker pull postgres:15.1

postgres:
	docker run --name postgres-simple-bank -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=123456 -d postgres:15.1

createdb:
	docker exec -it postgres-simple-bank createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres-simple-bank dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: pullimage postgres createdb dropdb migrateup migratedown sqlc