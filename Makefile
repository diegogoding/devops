

test:
	pytest

build:
	docker build -t webserver:latest .

run:build
	docker run --rm -it -p 8000:8000 webserver:latest

dev-install:
	pip install -r requirements-dev.txt --quiet

app-install:
	pip install -r webserver/requirements.txt --quiet

install: dev-install app-install

beanstalk:
	eb deploy

serverless:
	rm -rf infra/.terraform
	sls plugin install -n serverless-wsgi
	sls plugin install -n serverless-python-requirements
	sls deploy

tf-init:
	cd infra && \
	terraform init

tf-plan: tf-init
	cd infra && \
	terraform plan

tf-apply: tf-init
	cd infra && \
	terraform apply -auto-approve

tf-destroy: tf-init
	cd infra && \
	terraform destroy

tf-fmt:
	cd infra && \
	terraform fmt

