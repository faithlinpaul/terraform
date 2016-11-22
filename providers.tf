provider "aws" {
  access_key = "${var.tf_aws_access_key}"
  secret_key = "${var.tf_aws_secret_key}"
  region     = "${var.aws_region}"
}

# # Configure the Chef provider


# provider "chef" {


#      server_url = "https://api.chef.io/organizations/example/"


#      // You can set up a "Client" within the Chef Server management console.


#      client_name = "terraform"


#      private_key_pem = "${file(\"chef-terraform.pem\")}"


# }


# # Create a Chef Environment


# resource "chef_environment" "production" {


#     name = "production"


# }


# # Create a Chef Role


# resource "chef_role" "app_server" {


#     name = "app_server"


#     run_list = [


#         "recipe[terraform]"


#     ]


# }

