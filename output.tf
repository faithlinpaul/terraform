output "jenkins_master_ipaddress" {
  value = "${aws_instance.JenkinsMaster.public_ip}"
}

output "jenkins_slave_ipaddress" {
  value = "${aws_instance.JenkinsSlave.public_ip}"
}

output "jenkins_master_url" {
  value = "http://${aws_instance.JenkinsMaster.public_ip}:${var.jenkinsmaster_port}"
}

# output "ecrcommitter_access_key" {


#   value = "${aws_iam_access_key.ecrcommitter.id}"


# }


# id - The access key ID.


# user - The IAM user associated with this access key.


# secret - The secret access key. Note that this will be written to the state file.


# ses_smtp_password - The secret access key converted into an SES SMTP password by applying AWS's documented conversion algorithm.


# status - "Active" or "Inactive". Keys are initially active, but can be made inactive by other means. 

