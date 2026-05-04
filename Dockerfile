FROM python:3.13-slim

ARG UID=1000
ARG GID=1000

RUN apt update && apt install -y \
    make \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install poetry

RUN groupadd -g "${GID}" django && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" django

RUN mkdir -p /opt/app/tuto/project
RUN chown -R "${UID}:${GID}" /opt/app

USER django

WORKDIR /opt/app

COPY --chown="${UID}:${GID}" tuto/project/pyproject.toml tuto/project/poetry.lock /opt/app/tuto/project/
RUN poetry -C tuto/project install --no-interaction --no-ansi