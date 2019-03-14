resource "aws_ecs_task_definition" "webapp-demo" {
  family                   = "webapp-demo"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  task_role_arn            = "${var.task_role_arn}"
  execution_role_arn       = "${var.execution_role_arn}"

  container_definitions = <<-JSON
  [
    {
      "name": "web",
      "image": "${var.images["web"]}",
      "cpu": 256,
      "memory": 512,
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80
        }
      ],
      "mountPoints": [
        {
          "readOnly": true,
          "containerPath": "/tmp/sockets",
          "sourceVolume": "sockets"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/webapp-demo",
          "awslogs-region": "ap-northeast-1",
          "awslogs-stream-prefix": "ecs"
        }
      }
    },
    {
      "name": "webapp",
      "image": "${var.images["webapp"]}",
      "cpu": 256,
      "memory": 512,
      "essential": true,
      "portMappings": [],
      "environment": [
        {
          "name": "MYSQL_HOST",
          "value": "${var.rds["host"]}"
        },
        {
          "name": "MYSQL_PASS",
          "value": "${var.rds["password"]}"
        },
        {
          "name": "MYSQL_USER",
          "value": "${var.rds["user"]}"
        },
        {
          "name": "RAILS_ENV",
          "value": "development"
        },
        {
          "name": "RAILS_SOCKET",
          "value": "unix:///webapp/tmp/sockets/webapp.sock"
        },
        {
          "name": "REDIS_HOST",
          "value": "${var.elasticache["host"]}"
        }
      ],
      "mountPoints": [
        {
          "containerPath": "/webapp/tmp/sockets/",
          "sourceVolume": "sockets"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/webapp-demo",
          "awslogs-region": "ap-northeast-1",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]
  JSON

  volume {
    name = "sockets"
  }
}
