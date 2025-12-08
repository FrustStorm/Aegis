variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}


variable "aws_access_key" {
  type        = string
  description = "AWS access key"
}


variable "aws_secret_key" {
  type        = string
  description = "AWS secret key"
}



variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}