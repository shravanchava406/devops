# Creating AWS EC2-Instance using cli

1. Go to IAM in the mgmt console 
    
    a. --> Groups --> Created a group with Admin Permissions
    
    b. --> Users --> Created a new user and generated access keys (to use while logging in cli to create resources)
    
    c. --> Made a note of the Access Key id and secret in .env file.

2. In cli:
    
    a. Installed and configured AWS cli on macos:
    ```bash
    # Step 1: Download the AWS CLI v2 package for macOS
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"

    # Step 2: Install the AWS CLI v2 package
    sudo installer -pkg AWSCLIV2.pkg -target /

    # Step 3: Verify the installation
    which aws
    aws --version
    ```

3. Logged in to the AWS cli using Access key and Sceret (generated for the above user):

    ```bash
    aws configure
    # provided the access key and secret from the .env file
    ```
4. Used help commands under aws to navigate across to check few things

    ```bash
    1. aws ec2 describe-instances # to check if there are any availalbe ec2-instances

    2. aws ec2 create-key-pair --key-name <key_name> --query 'KeyMaterial' --output text > <key_name>.pem #Using this command we have created a Key Pair to make use of it while creating a resource. The key pair is basically used to login to any resource using ssh and its a must have.  

    3. chmod 400 <key_name>.pem # Used this to update the permissions on .pem file to make it visible only to current logged in user.
    
    4. aws ec2 describe-key-pairs --key-name <key_name> # To verify the key pairs
    ```

5. Command to create ec2-instance:

    1. Parameters used:
        
        - `--image-id` : AMI (Amazon Machine Image) ID specific to regions (usa-east-1 , usa-east-2 etc..)
        - `--count` : Number of ec2 instances needed
        - `--instance-type` : types of ec2 instances- small, micro, nano etc..,
        - `--tag-specifications` : To assign a name to the ec2 instance being created
            - example: `--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=<ec2_name>}]'`
        - `--key-name` : To assign the Key Pair to this ec2 instance (which allows us to login using ssh to the ec2 instance)
        - `--security-group-ids` : Use this to assign a list of (or a single) security group id's to the ec2 instance to provide access. 

6. Command to delete the instance or terminate the instance:

    ```bash
    aws ec2 terminate-instances --instance-id <instance_id>
    ```






