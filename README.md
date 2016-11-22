###  Devops Infrastructure ###

1. Setup AWS networking - VPC et al
2. Setup Jenkins Master and add it to Chef Server
3. Setup Jenkins Slave(s) and add it to Jenkins Master


#### Prerequisites ####

1. Create keys folder
`mkdir ./keys`

2. Create file  ./keys/aws.tfvars

3. Add aws key, secret from to  ./keys/aws.tfvars

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


#### TODO tasks: ####

- [ ] All setup should be production ready. Parameterize hardcoded values.
- [ ] Close 80 and 443 ports inbound and close down egress.
- [ ] Auto configure jenkins port 50000 for slave
- [ ] Avoid pulling ubuntu:14.04
- [ ] Create jenkins user on jenkins slave
- [ ] Give docker and git access only in sudoers for user jenkins by chef cookbook
- [ ] Jenkins plugin to switch between users to pull in docker images
- [ ] Modify jenkins file to update slave info as parameter.
- [ ] Modify jenkins job to update base image info in all other tool build jobs
- [ ] Copy jenkins Dockerfile from dockerhub and use it to build our own customized jenkins docker image.
- [ ] When hosting Internal-jenkins docker image auto configure secrets key

