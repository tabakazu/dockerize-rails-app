resource "aws_lb" "webapp-demo" {
  name               = "webapp-demo"
  load_balancer_type = "application"
  internal           = false
  security_groups    = "${var.security_groups}"
  subnets            = "${var.subnets}"
}

resource "aws_lb_target_group" "webapp-demo" {
  name        = "webapp-demo"
  protocol    = "HTTP"
  port        = 80
  target_type = "ip"
  vpc_id      = "${var.vpc_id}"

  health_check {
    interval            = 10
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "webapp-demo" {
  load_balancer_arn = "${aws_lb.webapp-demo.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.webapp-demo.arn}"
  }
}
