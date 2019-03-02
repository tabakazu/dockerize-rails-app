# Usage

Build project's container images
```bash
$ docker-compose build
```

Launched db and kvs container
```bash
$ docker-compose up -d db kvs
```

Create project's database
```bash
$ docker-compose run --rm webapp bundle exec rails db:create db:migrate
```

Launched webapp container
```bash
$ docker-compose up web webapp
```

Stop project's containers
```bash
$ docker-compose down
```