#!/usr/bin/env sh

set -x

# Create security group
sg="RDP_internet"

aws ec2 create-security-group --group-name $sg --description "Allow RDP access from internet"
aws ec2 authorize-security-group-ingress --group-name $sg --protocol tcp --port 3389 --cidr 0.0.0.0/0
aws ec2 describe-security-groups --group-names $sg

sg_id=$(aws ec2 describe-security-groups --group-names "RDP_internet" --query "SecurityGroups[0].GroupId" --output text)

# Determine latest AMI ID

#aws ec2 describe-images \
#  --owners 'amazon' \
#  --filters 'Name=description,Values=Amazon Linux AMI*' \
#  --query 'sort_by(Images, &CreationDate)[-1].[ImageId]' \
#  --output text

aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2

aws ssm get-parameters-by-path --path "/aws/service/ami-windows-latest"
aws ssm get-parameters --names /aws/service/ami-windows-latest/Windows_Server-2019-English-Full-Base

ami_id=$(aws ssm get-parameters --names /aws/service/ami-windows-latest/Windows_Server-2019-English-Full-Base --query "Parameters[0].Value" --output text)

# List Subnets
aws ec2 describe-subnets --query 'Subnets[*].[SubnetId, AvailabilityZone]' 

subnet_id=$(aws ec2 describe-subnets --filter "Name=availability-zone,Values=us-east-1a" --query "Subnets[0].SubnetId" --output text)

# Create a new virtual machine
aws ec2 run-instances \
  --subnet-id $subnet_id \
  --image-id $ami_id \
  --security-group-ids $sg_id \
  --key-name "treinaweb-lab" \
  --instance-type "t2.micro"
