# Dockerize Rails Project

## Setup

```bash
$ docker-compose up --build -d
$ docker-compose exec runner bundle install
$ docker-compose exec runner yarn install
$ docker-compose exec runner rails db:create
$ docker-compose exec runner rails db:migrate
```

## Starting Rails server ...

```bash
$ docker-compose up -d
$ docker-compose exec runner rails s -b '0.0.0.0'
```

## Remove containers

```bash
$ docker-compose down --rmi all --volumes
```
