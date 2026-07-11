output "ecr_repository_url" {

  value = aws_ecr_repository.springboot.repository_url

}


output "ecs_execution_role_arn" {

  value = aws_iam_role.ecs_execution_role.arn

}

output "ecs_cluster_name" {

  value = aws_ecs_cluster.main.name

}


output "task_definition_arn" {

  value = aws_ecs_task_definition.app.arn

}


output "load_balancer_url" {

  value = aws_lb.app.dns_name

}


output "ecs_service_name" {

  value = aws_ecs_service.app.name

}