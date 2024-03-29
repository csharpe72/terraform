resource "random_string" "random" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "aws_kms_key" "state_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  #bucket = "var.aws_bucket_name-${random_string.random.result}"
  #bucket = "jenkins-terraform-state-bucket-${random_string.random.result}" # Should be var.aws_bucket_name
  bucket = "jenkins-terraform-state-bucket-imminent"

  tags = merge(
    var.tags,
    {
      LaunchMonthYear = formatdate("MM-YYYY", timestamp())
    },
  )

  lifecycle {
    ignore_changes = [
      # Ensure tags are only added at the time of resource creation and not updated everytime I run terraform
      tags["LaunchMonthYear"]
    ]
    prevent_destroy = true
  }

}


resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.state_key.arn
      sse_algorithm     = "aws:kms"
      # sse_algorithm = "AES256"
    }
  }
}


resource "aws_s3_bucket_versioning" "bucket_version" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
