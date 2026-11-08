output "service_url" {
  value = aws_ecs_express_gateway_service.app.ingress_paths[0].endpoint
}

output "s3_bucket" {
  value = aws_s3_bucket.images.bucket
}