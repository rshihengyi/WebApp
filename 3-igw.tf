resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${local.env}-igw" # "Name" is special tag visible by default by aws
    }
}