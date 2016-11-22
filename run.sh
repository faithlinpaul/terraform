#!/bin/bash -v

terraform plan -var-file="./keys/aws.tfvars" 
#terraform apply -var-file="./keys/aws.tfvars" 