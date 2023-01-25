resource "aws_ecs_service" "drohealth_service" {
  name               = "drohealth_service"
  cluster            = "${aws_ecs_cluster.Analytic-portal.id}"
  task_definition    = "${aws_ecs_task_definition.Analytic-portal_task.arn}"
  launch_type        = "FARGATE"
  desired_count      = 1

  load_balancer {
    target_group_arn = "${aws_lb_target_group.drohealth_tg.arn}"
    container_name   = "${aws_ecs_task_definition.Analytic-portal_task.family}"
    container_port   = 3000 
  }

  network_configuration {
    subnets          = ["${aws_default_subnet.metabase_subnet_a.id}", "${aws_default_subnet.metabase_subnet_b.id}", "${aws_default_subnet.metabase_subnet_c.id}"]
    assign_public_ip = true
    security_groups  = ["${aws_security_group.service_security_group.id}"]
  }
}

resource "aws_security_group" "service_security_group" {
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    security_groups = ["${aws_security_group.metabase_sec_group.id}"]
  }

  egress {
    from_port   = 0 
    to_port     = 0 
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"] 
  }
}