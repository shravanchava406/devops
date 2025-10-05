#!/bin/bash

# GitHub Actions compatible AWS CLI installation script for Linux
echo "Installing AWS CLI v2 for Linux..."

# Step 1: Download the AWS CLI v2 package for Linux
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Step 2: Unzip the package
unzip awscliv2.zip

# Step 3: Install the AWS CLI v2 package
sudo ./aws/install

# Step 4: Verify the installation
echo "Verifying AWS CLI installation..."
echo "--------------------------------"
echo "AWS CLI INSTALLATION PATH:"
which aws
echo "--------------------------------"
echo "AWS CLI VERSION:"
aws --version

# Cleanup
rm -rf awscliv2.zip aws/