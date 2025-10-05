#!/bin/bash

# GitHub Actions compatible key pair creation script
echo "Creating AWS EC2 Key Pair..."

# Check if required environment variable is set
if [ -z "$AWS_EC2_KEY_PAIR_NAME" ]; then
    echo "Error: AWS_EC2_KEY_PAIR_NAME environment variable is not set"
    exit 1
fi

# Check if key pair already exists
if aws ec2 describe-key-pairs --key-name $AWS_EC2_KEY_PAIR_NAME 2>/dev/null; then
    echo "Key pair $AWS_EC2_KEY_PAIR_NAME already exists. Skipping creation."
else
    echo "Creating new key pair: $AWS_EC2_KEY_PAIR_NAME"
    aws ec2 create-key-pair --key-name $AWS_EC2_KEY_PAIR_NAME --query 'KeyMaterial' --output text > $AWS_EC2_KEY_PAIR_NAME.pem

    echo "Updating permissions on .pem file"
    chmod 400 $AWS_EC2_KEY_PAIR_NAME.pem

    echo "Key pair created successfully."
fi

echo "Listing the details for key pair:"
aws ec2 describe-key-pairs --key-name $AWS_EC2_KEY_PAIR_NAME