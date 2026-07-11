resource "aws_lb" "app" {

  name = "${var.project_name}-alb"

  load_balancer_type = "application"

  internal = false

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  tags = {
    Name = "${var.project_name}-alb"
  }
}

resource "aws_lb_target_group" "app" {

  name = "${var.project_name}-tg"

  port = 8080

  protocol = "HTTP"

  target_type = "ip"

  vpc_id = aws_vpc.main.id


  health_check {

    enabled = true

    path = "/actuator/health"

    matcher = "200-399"

    interval = 30

    timeout = 5

    healthy_threshold = 2

    unhealthy_threshold = 3
  }


  tags = {
    Name = "${var.project_name}-tg"
  }

}


resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.app.arn


  port = 80

  protocol = "HTTP"


  default_action {

    type = "forward"


    target_group_arn = aws_lb_target_group.app.arn

  }

}

