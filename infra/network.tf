

resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
}


resource "aws_subnet" "public_dev" {
  count             = length(var.subnets_cidr)
  vpc_id            = aws_vpc.dev.id
  cidr_block        = element(var.subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    name = "subnet-${element(var.subnets_cidr, count.index)}"
    vpc  = aws_vpc.dev.id
  }
}


# Route table: attach Internet Gateway
resource "aws_route_table" "public_dev_rt" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev.id
  }
  tags = {
    Name = "publicRouteTable"
  }
}

# Route table association with public subnets
resource "aws_route_table_association" "a" {
  count          = length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.public_dev.*.id, count.index)
  route_table_id = aws_route_table.public_dev_rt.id

}

resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id
}