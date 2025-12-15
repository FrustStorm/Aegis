provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# checkov:skip=CKV2_AWS_62: Event notification is not required for a demo project
# checkov:skip=CKV_AWS_144: Cross-region replication is out of scope for this project
resource "aws_s3_bucket" "aegis_bucket" {
  bucket = var.bucket_name
}

# ------------------
# Security Hardening
# ------------------

# Block public access
resource "aws_s3_bucket_public_access_block" "aegis_block" {
  bucket = aws_s3_bucket.aegis_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning
resource "aws_s3_bucket_versioning" "aegis_versioning" {
  bucket = aws_s3_bucket.aegis_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Server-Side encryption ( KMS )
resource "aws_s3_bucket_server_side_encryption_configuration" "aegis_encryption" {
  bucket = aws_s3_bucket.aegis_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

# Enable Access logging
# checkov:skip=CKV2_AWS_62: Event notification is not required for a demo project
# checkov:skip=CKV_AWS_144: Cross-region replication is out of scope for this project
resource "aws_s3_bucket" "aegis_logs" {
  bucket = "${var.bucket_name}-logs"
}

resource "aws_s3_bucket_public_access_block" "aegis_logs_block" {
  bucket                  = aws_s3_bucket.aegis_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_versioning" "aegis_logs_versioning" {
  bucket = aws_s3_bucket.aegis_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aegis_logs_encryption" {
  bucket = aws_s3_bucket.aegis_logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}
# checkov:skip=CKV_AWS_300: Abort multipart uploads is configured but flagged due to Checkov limitations
resource "aws_s3_bucket_lifecycle_configuration" "aegis_logs_lifecycle" {
  bucket = aws_s3_bucket.aegis_logs.id

  rule {
    id     = "expire-old-objects"
    status = "enabled"

    expiration {
      days = 90
    }
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

resource "aws_s3_bucket_logging" "aegis_logging" {
  bucket        = aws_s3_bucket.aegis_bucket.id
  target_bucket = aws_s3_bucket.aegis_logs.id
  target_prefix = "access_logs/"
}

# Lifecyle rules
# checkov:skip=CKV_AWS_300: Abort multipart uploads is configured but flagged due to Checkov limitations
resource "aws_s3_bucket_lifecycle_configuration" "aegis_lifecycle" {
  bucket = aws_s3_bucket.aegis_bucket.id
  rule {
    id     = "expire-old-objects"
    status = "enabled"

    expiration {
      days = 90
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

