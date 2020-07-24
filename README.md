# Dockerize Rails Application

## Setup

```bash
$ docker-compose build
$ docker-compose run --rm rails bin/setup
```

## Starting Rails server ...

```bash
$ docker-compose up rails
```

## Remove containers

```bash
$ docker-compose down --rmi all --volumes
```
