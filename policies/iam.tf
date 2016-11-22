#iam

resource "aws_iam_group" "ecrcommitters" {
  name = "ecrcommitters"

  # path = "/users/"
}

resource "aws_iam_user" "ecrcommitter" {
  name = "ecrcommitter"
}

resource "aws_iam_group_membership" "ecrcommitters-membership" {
  name = "ecrcommitters-membership"

  users = [
    "${aws_iam_user.ecruser.name}",
  ]

  group = "${aws_iam_group.ecrgroup.name}"
}

resource "aws_iam_group_policy_attachment" "AmazonEC2ContainerRegistryFullAccess" {
  group      = "${aws_iam_group.ecrcommitters.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_group_policy_attachment" "AmazonEC2ContainerServiceforEC2Role" {
  group      = "${aws_iam_group.ecrcommitters.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_group_policy_attachment" "AmazonEC2ContainerServiceRole" {
  group      = "${aws_iam_group.ecrcommitters.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerServiceRole"
}

resource "aws_iam_user_ssh_key" "ecrcommitter" {
  username = "${aws_iam_user.ecrcommitter.name}"
  encoding = "PEM"

  public_key = "${file(var.public_key_path)}"
}

# ssh_public_key_id - The unique identifier for the SSH public key.
# fingerprint - The MD5 message digest of the SSH public key.

resource "aws_iam_access_key" "ecrcommitter" {
  user = "${aws_iam_user.ecrcommitter.name}"
}

# AmazonEC2ContainerRegistryFullAccess


# AmazonEC2ContainerServiceforEC2Role


# AmazonEC2ContainerServiceRole


# resource "aws_iam_policy" "policy" {


#     name = "test_policy"


#     path = "/"


#     description = "My test policy"


#     policy = <<EOF


# {


#   "Version": "2012-10-17",


#   "Statement": [


#     {


#       "Action": [


#         "ec2:Describe*"


#       ],


#       "Effect": "Allow",


#       "Resource": "*"


#     }


#   ]


# }


# EOF


# }

