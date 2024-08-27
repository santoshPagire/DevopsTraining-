resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "main" {
  family                   = var.task_family_name
  container_definitions    = jsonencode([{
    name      = "my-container"
    image     = "nginx:latest"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
    environment = var.container_environment
  }])
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
}

resource "aws_ecs_service" "main" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 3
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.public_subnets
    security_groups = [var.alb_security_group_id]
  }
}

resource "aws_alb_target_group" "main" {
  name     = "${var.name}-tg"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
   target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
