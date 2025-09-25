resource "aws_security_group" "jenkins_sg" {
  name   = "${var.cluster_name}-jenkins-sg"
  vpc_id = aws_vpc.this.id

  ingress {
    description = "Jenkins web"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"]}
}

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.small"
  key_name      = var.jenkins_key_name
  subnet_id     = values(aws_subnet.public)[0].id
  security_groups = [aws_security_group.jenkins_sg.id]

  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name

  user_data = file("${path.module}/../jenkins/bootstrap-jenkins.sh")
  tags = { Name = "${var.cluster_name}-jenkins" }
}
