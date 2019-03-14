resource "aws_ecs_service" "webapp-demo" {
  name            = "webapp-demo"
  cluster         = "${aws_ecs_cluster.webapp-demo.id}"
  task_definition = "${aws_ecs_task_definition.webapp-demo.arn}"
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = "${aws_lb_target_group.webapp-demo.arn}"
    container_name   = "web"
    container_port   = 80
  }

  network_configuration = {
    assign_public_ip = true
    security_groups  = "${var.security_groups}"
    subnets          = "${var.subnets}"
  }

  depends_on = ["aws_lb_listener.webapp-demo"]
}
