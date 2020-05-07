# Dockerize Rails Project

## Setup

```bash
$ docker-compose build

$ docker-compose run --rm --service-ports rails bash
docker > bundle
docker > yarn
docker > rails db:create
docker > rails db:migrate
```

## Starting Rails server ...

```bash
$ docker-compose up -d
```

## Remove containers

```bash
$ docker-compose down --rmi all --volumes
```
