resource "aws_ecr_repository" "web" {
  name = "dockerize-webapp-demo/web"
}

resource "aws_ecr_repository" "webapp" {
  name = "dockerize-webapp-demo/webapp"
}
