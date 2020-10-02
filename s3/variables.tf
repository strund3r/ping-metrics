variable "aws_profile" {
  description = "Name of AWS profile in AWS shared credentials file or AWS shared configuration file."
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}

variable "aws_credential" {
  description = "Path to the AWS shared credentials file."
  type        = string
  default     = "~/.aws/credentials"
}