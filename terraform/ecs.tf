resource "aws_ecs_cluster" "main" {

  name = "${var.project_name}-cluster"

  tags = {
    Name = "${var.project_name}-cluster"
  }
}

resource "aws_cloudwatch_log_group" "ecs_logs" {

  name = "/ecs/${var.project_name}"

  retention_in_days = 7

}

resource "aws_ecs_task_definition" "app" {

  family = "${var.project_name}-task"

  network_mode = "awsvpc"

  requires_compatibilities = [
    "FARGATE"
  ]

  cpu = "256"

  memory = "512"


  execution_role_arn = aws_iam_role.ecs_execution_role.arn


  container_definitions = jsonencode([

    {

      name = "springboot-container"


      image = "${aws_ecr_repository.springboot.repository_url}:latest"


      essential = true


      portMappings = [

        {

          containerPort = 8080

          protocol = "tcp"

        }

      ]


      logConfiguration = {

        logDriver = "awslogs"


        options = {

          awslogs-group = aws_cloudwatch_log_group.ecs_logs.name


          awslogs-region = var.aws_region


          awslogs-stream-prefix = "ecs"

        }

      }

    }

  ])


  tags = {

    Name = "${var.project_name}-task"

  }

}

resource "aws_ecs_service" "app" {

  name = "${var.project_name}-service"


  cluster = aws_ecs_cluster.main.id


  task_definition = aws_ecs_task_definition.app.arn


  desired_count = 1


  launch_type = "FARGATE"


  platform_version = "LATEST"


  network_configuration {

    subnets = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id
    ]


    security_groups = [
      aws_security_group.ecs_sg.id
    ]


    assign_public_ip = true

  }


  load_balancer {

    target_group_arn = aws_lb_target_group.app.arn


    container_name = "springboot-container"


    container_port = 8080

  }


  depends_on = [
    aws_lb_listener.http
  ]


  tags = {

    Name = "${var.project_name}-service"

  }

}