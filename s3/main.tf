provider "aws" {
  region = "ap-south-1"
}

resource "random_id" "my-random-id" {
  byte_length = 2
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "${var.s3_bucket_name}-${random_id.my-random-id.dec}"

  tags = {
    Name = "arvind-bucket-2022"
  }
}

resource "aws_s3_bucket_acl" "acl-bucket" {
  bucket = aws_s3_bucket.my-test-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_s3" {
  bucket = aws_s3_bucket.my-test-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle-s3" {
  bucket = aws_s3_bucket.my-test-bucket.id

  rule {
    id = "rule-1"

    filter {}
    status = "Enabled"
  }
}  

resource "aws_s3_bucket_intelligent_tiering_configuration" "s3-entire-bucket" {
  bucket = aws_s3_bucket.my-test-bucket.bucket
  name   = "EntireBucket"
  
  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 180
  }
  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 125
  }
}
