pullimage:
	docker pull postgres:15.1-alpine3.17

postgres:
	docker run --name postgres --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=123456 -d postgres:15.1-alpine3.17

createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres dropdb simple_bank

dockerrunserver:
	docker build -t simplebank:latest .
	docker run --name simplebank --network bank-network -p 8080:8080 -e GIN_MODE=release -e DB_SOURCE="postgresql://root:123456@postgres:5432/simple_bank?sslmode=disable" simplebank:latest

migrateup:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

resetdb:
	make migratedown
	make migrateup

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/dhruv-1001/go-simple-bank/db/sqlc Store

format:
	gofmt -s -w .

.PHONY: pullimage postgres createdb dropdb dockerrunserver migrateup migrateup1 migratedown migratedown1 sqlc resetdb server mock format