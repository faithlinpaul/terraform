#jenkins Master

resource "aws_instance" "JenkinsMaster" {
  connection {
    user        = "ubuntu"
    private_key = "${file(var.private_key_path)}"
  }

  /*user_data = "${template_file.userdata.rendered}"*/

  instance_type          = "${var.instance_type}"
  ami                    = "${lookup(var.aws_amis, var.aws_region)}"
  key_name               = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.jenkins_master.id}"]
  subnet_id              = "${aws_subnet.default.id}"
  provisioner "remote-exec" {
    inline = [
      "sudo sh -c \"echo '35.163.78.214 chefserver' >> /etc/hosts\"",
      "sudo apt-get update -y",
    ]
  }
  tags {
    Name = "MGMT_TOOLING_JENKINS_MASTER_TERRAFROM"

    # Name = "Group:MGMT_TOOLING;Type:JENKINS_MASTER"

    # Type = "JENKINS_MASTER"
  }
  provisioner "chef" {
    environment = "${var.chef_env_name}"

    fetch_chef_certificates = "true"

    #Todo: use chef cookbook to update sudoers file
    run_list = ["java::oracle", "jenkins::master"]

    node_name = "JenkinsMaster"

    /*secret_key = "${file("../encrypted_data_bag_secret")}"*/

    server_url      = "https://${var.chef_server_name}/organizations/${var.chef_organization_name}"
    recreate_client = true
    user_name       = "${var.chef_user_name}"
    user_key        = "${file(var.chef_admin_key_path)}"
    version         = "${var.chef_version}"
  }
  provisioner "remote-exec" {
    inline = [
      # Configure docker git
      "sudo apt-get update",

      # "sudo apt-get install apt-transport-https ca-certificates -y",
      # "sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D -y",
      # "echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' | sudo tee /etc/apt/sources.list.d/docker.list",
      # "sudo apt-get update",
      # "sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual -y",
      # "sudo apt-get install docker-engine -y",
      # "sudo service docker start",
      "sudo apt-get install git -y",
    ]
  }
}
