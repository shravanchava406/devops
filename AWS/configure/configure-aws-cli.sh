#!/bin/bash

# GitHub Actions compatible AWS CLI configuration script
echo "Configuring AWS CLI..."

# Check if environment variables are set
if [ -z "$AWS_CLI_KEY_ID" ] || [ -z "$AWS_CLI_KEY_SECRET" ] || [ -z "$AWS_REGION" ]; then
    echo "Error: Required environment variables are not set:"
    echo "  AWS_CLI_KEY_ID: ${AWS_CLI_KEY_ID:+set}"
    echo "  AWS_CLI_KEY_SECRET: ${AWS_CLI_KEY_SECRET:+set}" 
    echo "  AWS_REGION: ${AWS_REGION:+set}"
    exit 1
fi

aws configure set aws_access_key_id $AWS_CLI_KEY_ID
aws configure set aws_secret_access_key $AWS_CLI_KEY_SECRET
aws configure set region $AWS_REGION 
aws configure set output json

echo "AWS CLI configured with provided credentials and region."
echo "Current AWS configuration:"
aws configure list