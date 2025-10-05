#!/bin/bash

# GitHub Actions compatible EC2 instance creation script
echo "Creating EC2 Instance..."

# Check if required environment variables are set
required_vars=("AWS_EC2_US_EAST_1_AMI_BASE_LINUX_X86_64_ID" "AWS_EC2_INSTANCE_COUNT" "AWS_EC2_INSTANCE_TYPE" "AWS_EC2_INSTANCE_NAME" "AWS_EC2_KEY_PAIR_NAME" "AWS_EC2_SECURITY_GROUPS")

for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "Error: Required environment variable $var is not set"
        exit 1
    fi
done

# Check if instance with the same name already exists and is running
EXISTING_INSTANCE=$(aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=$AWS_EC2_INSTANCE_NAME" "Name=instance-state-name,Values=running,pending" \
  --query 'Reservations[*].Instances[*].InstanceId' \
  --output text)

if [ ! -z "$EXISTING_INSTANCE" ]; then
    echo "Instance with name $AWS_EC2_INSTANCE_NAME already exists and is running: $EXISTING_INSTANCE"
    echo "Skipping instance creation."
else
    echo "Creating new EC2 instance with the following parameters:"
    echo "  AMI ID: $AWS_EC2_US_EAST_1_AMI_BASE_LINUX_X86_64_ID"
    echo "  Count: $AWS_EC2_INSTANCE_COUNT"
    echo "  Type: $AWS_EC2_INSTANCE_TYPE" 
    echo "  Name: $AWS_EC2_INSTANCE_NAME"
    echo "  Key Pair: $AWS_EC2_KEY_PAIR_NAME"
    echo "  Security Groups: $AWS_EC2_SECURITY_GROUPS"

    INSTANCE_RESULT=$(aws ec2 run-instances \
      --image-id $AWS_EC2_US_EAST_1_AMI_BASE_LINUX_X86_64_ID \
      --count $AWS_EC2_INSTANCE_COUNT \
      --instance-type $AWS_EC2_INSTANCE_TYPE \
      --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$AWS_EC2_INSTANCE_NAME}]" \
      --key-name $AWS_EC2_KEY_PAIR_NAME \
      --security-group-ids $AWS_EC2_SECURITY_GROUPS)

    INSTANCE_ID=$(echo $INSTANCE_RESULT | jq -r '.Instances[0].InstanceId')
    echo "EC2 Instance created successfully with ID: $INSTANCE_ID"

    echo "Waiting for instance to be in running state..."
    aws ec2 wait instance-running --instance-ids $INSTANCE_ID

    echo "Instance is now running. Getting instance details..."
    aws ec2 describe-instances --instance-ids $INSTANCE_ID
fi