variable "ami_id" {
  type    = string
  default = "ami-0e8ffa060937e44c7"
}

locals {
    app_name = "pet-clinic-ami"
}

source "amazon-ebs" "petclinic" {
  ami_name      = "${local.app_name}"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami    = "${var.ami_id}"
  ssh_username  = "ubuntu"
  tags = {
    Env  = "DEMO"
    Name = "${local.app_name}"
  }
}

build {
  sources = ["source.amazon-ebs.petclinic"]

  provisioner "file" {
    source = "/home/ubuntu/workspace/APPLICATION PIPELINES/app/petclinic/target/spring-petclinic-3.1.0-SNAPSHOT.jar"
    destination = "/home/ubuntu/spring-petclinic.jar"
  }
}
