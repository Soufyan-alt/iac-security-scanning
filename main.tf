# 1. المجموعة الأمنية المحمية (إغلاق المنفذ 22 عن العامة)
resource "aws_security_group" "secure_sg" {
  name        = "secure-ssh"
  description = "Allow SSH only from internal secure network"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] 
  }
}

# 2. مستودع S3 الرئيسي المؤمن
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "my-secure-devsecops-bucket"
}

# تفعيل الـ Versioning
resource "aws_s3_bucket_versioning" "secure_bucket_versioning" {
  bucket = aws_s3_bucket.secure_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# حل ثغرة التشفير الافتراضي الصارم (CKV_AWS_145)
resource "aws_s3_bucket_server_side_encryption_configuration" "secure_bucket_crypto" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# حل ثغرة دورة حياة البيانات (CKV2_AWS_61)
resource "aws_s3_bucket_lifecycle_configuration" "secure_bucket_lifecycle" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    id     = "cleanup-old-data"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

# حظر الوصول العام تماماً عن المستودع
resource "aws_s3_bucket_public_access_block" "secure_bucket_block" {
  bucket = aws_s3_bucket.secure_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
