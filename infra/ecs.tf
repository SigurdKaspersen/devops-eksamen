data "aws_ecr_repository" "app" {
  name = "wishifai-${var.candidate_number}"
}

resource "aws_ecs_express_gateway_service" "app" {
  service_name            = "wishifai-${var.candidate_number}"
  execution_role_arn      = "arn:aws:iam::244530008913:role/ecsTaskExecutionRole"
  infrastructure_role_arn = "arn:aws:iam::244530008913:role/service-role/ecsInfrastructureRoleForExpressServices"
  task_role_arn           = aws_iam_role.task.arn
  health_check_path       = "/actuator/health"
  wait_for_steady_state   = true

  primary_container {
    image          = "${data.aws_ecr_repository.app.repository_url}:${var.image_tag}"
    container_port = 8080

    environment {
      name  = "S3_BUCKET"
      value = aws_s3_bucket.images.bucket
    }
  }

  depends_on = [aws_iam_role_policy.task]
}