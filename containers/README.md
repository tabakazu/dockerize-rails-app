# Usage

Build project's container images
```bash
$ docker-compose build
```

Launched project's containers
```bash
$ docker-compose up -d
```

Create project's database
```bash
$ docker-compose run --rm webapp bundle exec rails db:create db:migrate
```

Stop project's containers
```bash
$ docker-compose down
```