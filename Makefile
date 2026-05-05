##
# Tuto for Django
#
# @file
# @version 0.1
MAKEFLAGS+="-j 2"

.PHONY: build
build:
	docker compose build

.PHONY: build-dev
build-dev:
	docker compose build --progress=plain --no-cache

.PHONY: dev
dev:
	docker compose up -d

.PHONY: bash
bash:
	docker compose run tuto_django bash

.PHONY: poetry-lock
poetry-lock:
	docker compose run tuto_django poetry lock

.PHONY: poetry-lock
poetry-add:
	docker compose run tuto_django poetry add $(pkg)


.PHONY: poetry-update
poetry-update:
	docker compose run tuto_django poetry update

.PHONY: update
update:
	docker compose run tuto_django make -C tuto/project update


.PHONY: shell
shell:
	docker compose run tuto_django poetry run python manage.py shell_plus

.PHONY: logs
logs:
	docker compose logs tuto_django -f


.PHONY: create_admin
create_admin:
	docker compose run tuto_django make -C tuto/project create_admin

.PHONY: django_ip
django_ip:
	docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' tuto_django > project/internal_django_ip_address.txt
