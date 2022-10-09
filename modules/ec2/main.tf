resource "aws_instance" "app_server" {
  ami           = data.aws_ssm_parameter.ec2-ami.value
  instance_type = var.instance_type
  count = var.instance_count

  tags = {
    Name = "ec2-app_server-aws_instance-${count.index + 1}"  #modulename-resource_name-resource_type

  }

}

data "aws_ssm_parameter" "ec2-ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}