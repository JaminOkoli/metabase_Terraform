resource "aws_default_vpc" "main" {
}

resource "aws_default_subnet" "metabase_subnet_a" {
  availability_zone = "us-east-1a"
}

resource "aws_default_subnet" "metabase_subnet_b" {
  availability_zone = "us-east-1b"
}

resource "aws_default_subnet" "metabase_subnet_c" {
  availability_zone = "us-east-1c"
}