###  Devops Infrastructure ###

1. Setup AWS networking - VPC et al
2. Setup Jenkins Master and add it to Chef Server
3. Setup Jenkins Slave(s) and add it to Jenkins Master


#### Prerequisites ####

1. Create keys folder `mkdir ./keys`

2. Create file  `touch ./keys/aws.tfvars`

3. Add aws key, secret from your aws account and save to `./keys/aws.tfvars`

```
tf_aws_access_key = <ACCESSKEY>
tf_aws_secret_key = <SECRETKEY>
```

4. Repeat step 3 for `jenkinsslave_aws_ecr_access_key` and `jenkinsslave_aws_ecr_secret_key`

5. Create ssh key pair for chef provisioning, save both pem and pub in ./keys

`ssh-keygen -b 2048 -C "youremail@somewhere.com"`

6. Add chefserver admin private key to `chef_admin_key_path` 


#### Usage ####

```
terraform plan -var-file="./keys/aws.tfvars" 
terraform apply -var-file="./keys/aws.tfvars" 
```

      
      
"${var.chef_server_ipentry}",