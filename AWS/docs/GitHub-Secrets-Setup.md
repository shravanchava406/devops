# GitHub Secrets Setup for AWS EC2 Deployment

This document provides step-by-step instructions to set up all the required environment variables as GitHub secrets for the AWS EC2 deployment workflow.

## Prerequisites

Before setting up GitHub secrets, you need:
1. An AWS account with administrative access
2. An IAM user with programmatic access and appropriate permissions
3. Access to your GitHub repository settings

## AWS Setup Steps

### Step 1: Create IAM User and Access Keys

1. **Go to IAM Console**
   - Log in to AWS Management Console
   - Navigate to IAM (Identity and Access Management)

2. **Create a New User**
   - Click on "Users" in the left sidebar
   - Click "Create user" button
   - Enter username (e.g., `github-actions-user`)
   - Select "Programmatic access" for Access type

3. **Attach Permissions**
   - Choose "Attach existing policies directly"
   - Search and select the following policies:
     - `AmazonEC2FullAccess` (for EC2 operations)
     - Or create a custom policy with specific permissions if you prefer least privilege

4. **Generate Access Keys**
   - Complete the user creation process
   - **Important**: Save the Access Key ID and Secret Access Key immediately
   - These will be used in GitHub secrets

### Step 2: Gather AWS Resource Information

1. **Get AMI ID**
   - Go to EC2 Console → AMIs
   - Find a suitable Amazon Linux 2 AMI for your region
   - Copy the AMI ID (e.g., `ami-0abcdef1234567890`)

2. **Create/Find Security Group**
   - Go to EC2 Console → Security Groups
   - Create a new security group or use existing one
   - Note down the Security Group ID (e.g., `sg-0123456789abcdef0`)

## GitHub Secrets Setup

### Step 3: Add Secrets to GitHub Repository

1. **Navigate to Repository Settings**
   - Go to your GitHub repository
   - Click on "Settings" tab
   - Select "Secrets and variables" → "Actions" from the left sidebar

2. **Add Repository Secrets**
   
   Click "New repository secret" for each of the following:

#### AWS Authentication Secrets
   
   **Secret Name**: `AWS_CLI_KEY_ID`  
   **Value**: Your AWS Access Key ID from Step 1  
   **Description**: AWS Access Key ID for authentication

   **Secret Name**: `AWS_CLI_KEY_SECRET`  
   **Value**: Your AWS Secret Access Key from Step 1  
   **Description**: AWS Secret Access Key for authentication

#### AWS Configuration Secrets

   **Secret Name**: `AWS_REGION`  
   **Value**: `us-east-1` (or your preferred region)  
   **Description**: AWS region where resources will be created

#### EC2 Instance Configuration Secrets

   **Secret Name**: `AWS_EC2_US_EAST_1_AMI_BASE_LINUX_X86_64_ID`  
   **Value**: `ami-0abcdef1234567890` (replace with actual AMI ID)  
   **Description**: AMI ID for the EC2 instance (Amazon Linux 2 x86_64)

   **Secret Name**: `AWS_EC2_INSTANCE_COUNT`  
   **Value**: `1`  
   **Description**: Number of EC2 instances to create

   **Secret Name**: `AWS_EC2_INSTANCE_TYPE`  
   **Value**: `t2.micro` (or your preferred instance type)  
   **Description**: EC2 instance type

   **Secret Name**: `AWS_EC2_INSTANCE_NAME`  
   **Value**: `github-actions-instance` (or your preferred name)  
   **Description**: Name tag for the EC2 instance

   **Secret Name**: `AWS_EC2_KEY_PAIR_NAME`  
   **Value**: `github-actions-keypair` (or your preferred key pair name)  
   **Description**: Name for the EC2 key pair

   **Secret Name**: `AWS_EC2_SECURITY_GROUPS`  
   **Value**: `sg-0123456789abcdef0` (replace with actual security group ID)  
   **Description**: Security group ID(s) for the EC2 instance

## Example .env File for Local Development

If you want to run the scripts locally, create a `.env` file in the `AWS/` directory with the following content:

```bash
# AWS Authentication
AWS_CLI_KEY_ID=your_access_key_id_here
AWS_CLI_KEY_SECRET=your_secret_access_key_here
AWS_REGION=us-east-1

# EC2 Instance Configuration
AWS_EC2_US_EAST_1_AMI_BASE_LINUX_X86_64_ID=ami-0abcdef1234567890
AWS_EC2_INSTANCE_COUNT=1
AWS_EC2_INSTANCE_TYPE=t2.micro
AWS_EC2_INSTANCE_NAME=my-test-instance
AWS_EC2_KEY_PAIR_NAME=my-keypair
AWS_EC2_SECURITY_GROUPS=sg-0123456789abcdef0
```

## Security Best Practices

1. **Never commit the .env file to version control**
   - Add `.env` to your `.gitignore` file
   - Only use it for local development

2. **Rotate Access Keys Regularly**
   - Generate new access keys periodically
   - Update GitHub secrets when keys are rotated

3. **Use Least Privilege Principle**
   - Only grant necessary permissions to the IAM user
   - Consider using IAM roles for EC2 instances instead of embedded credentials

4. **Monitor Usage**
   - Enable CloudTrail to monitor API usage
   - Set up billing alerts for unexpected charges

## Common AMI IDs by Region

Here are some common Amazon Linux 2 AMI IDs (these change periodically, so verify current IDs):

- **us-east-1**: `ami-0abcdef1234567890`
- **us-west-2**: `ami-0123456789abcdef0` 
- **eu-west-1**: `ami-0fedcba0987654321`

To find the latest AMI ID for your region:
```bash
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' --output text
```

## Troubleshooting

### Common Issues:

1. **Invalid AMI ID**: Ensure the AMI ID is valid for your selected region
2. **Security Group Not Found**: Verify the security group exists in the same region
3. **Insufficient Permissions**: Ensure the IAM user has necessary EC2 permissions
4. **Key Pair Already Exists**: The workflow handles existing key pairs automatically

### Testing the Setup:

Run the workflow manually using the "workflow_dispatch" trigger to test your configuration before pushing changes.

## Workflow Triggers

The GitHub Actions workflow will run:
- When manually triggered via "Actions" tab → "Run workflow"
- When code is pushed to the `main` branch with changes in the `AWS/` directory

This ensures the deployment only runs when AWS-related files are modified.