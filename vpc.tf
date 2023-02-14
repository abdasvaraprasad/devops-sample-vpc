
# 1. VPC
resource "aws_vpc" "devops-vpc" {
  cidr_block           = "10.16.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

## 2. Create Subnets

# # ## public subnets

resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.devops-vpc.id
  map_public_ip_on_launch = true
  cidr_block              = "10.16.16.0/23"
  availability_zone       = "us-west-1a"

  tags = {
    Name = "public-subnet-1"
  }
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.devops-vpc.id
  map_public_ip_on_launch = true
  cidr_block              = "10.16.80.0/23"
  availability_zone       = "us-west-1b"

  tags = {
    Name = "public-subnet-2"
  }
}


# ## private subnets

resource "aws_subnet" "application-private-1" {
  vpc_id                  = aws_vpc.devops-vpc.id
  map_public_ip_on_launch = false
  cidr_block              = "10.16.32.0/23"
  availability_zone       = "us-west-1a"

  tags = {
    Name = "application-private-1"
  }
}
resource "aws_subnet" "application-private-2" {
  vpc_id                  = aws_vpc.devops-vpc.id
  map_public_ip_on_launch = false
  cidr_block              = "10.16.96.0/23"
  availability_zone       = "us-west-1b"

  tags = {
    Name = "application-private-2"
  }
}

resource "aws_subnet" "database-private-1" {
  vpc_id                  = aws_vpc.devops-vpc.id
  map_public_ip_on_launch = false
  cidr_block              = "10.16.40.0/23"
  availability_zone       = "us-west-1a"

  tags = {
    Name = "database-private-1"
  }
}

resource "aws_subnet" "database-private-2" {
  vpc_id                  = aws_vpc.devops-vpc.id
  map_public_ip_on_launch = false
  cidr_block              = "10.16.50.0/23"
  availability_zone       = "us-west-1b"

  tags = {
    Name = "database-private-2"
  }
}

# ## IGW
resource "aws_internet_gateway" "devops-igw" {
  vpc_id = aws_vpc.devops-vpc.id

  tags = {
    Name = "devops-igw"
  }
}

# # ## Route table

resource "aws_route_table" "devops-public-rt" {
  vpc_id = aws_vpc.devops-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops-igw.id
  }

  tags = {
    Name = "public-route-table-demo"
  }
}

resource "aws_route_table_association" "public-association-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.devops-public-rt.id
}

resource "aws_route_table_association" "public-association-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.devops-public-rt.id
}

## IAM Role


## IAM Role policy attachment


## Create Security group

## Create EC2

## pre-req (keypair, amiid, )
resource "aws_instance" "default" {
  ami               = "ami-0036b4598ccd42565"
  availability_zone = "us-west-1a"
  instance_type     = "t2.micro"
  #iam_instance_profile                 = local.instance_profile
  associate_public_ip_address = true
  key_name                    = "devops-west-keypair"
  subnet_id                   = aws_subnet.public-subnet-1.id
  tenancy                     = "default"
}

## Add user data