build:
	docker build -t fattura24:2.4 -f Dockerfile.2.4 .
	docker build -t fattura24:2.5 -f Dockerfile.2.5 .
	docker build -t fattura24:2.6 -f Dockerfile.2.6 .
	docker build -t fattura24:2.7 -f Dockerfile.2.7 .
	docker build -t fattura24:3.0 -f Dockerfile.3.0 .

.DEFAULT_GOAL := default

default:
	docker run fattura24:2.4 && docker run fattura24:2.5 && docker run fattura24:2.6 && docker run fattura24:2.7 && docker run fattura24:3.0
