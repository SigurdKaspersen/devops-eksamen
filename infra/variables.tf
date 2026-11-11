variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "candidate_number" {
  description = "Candidate number for unique names"
  type        = string
  default     = "31"
}

variable "image_tag" {
  description = "Docker image version (commit SHA)"
  type        = string
}

variable "alarm_email" {
  type = string
}