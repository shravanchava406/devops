# AWS CLI Login Script

#load environment variables from .env file

source /Users/shrushra/Desktop/devops/AWS/.env
aws configure set aws_access_key_id $AWS_CLI_KEY_ID # Providing Key Id for the access key created for user on AWS
aws configure set aws_secret_access_key $AWS_CLI_KEY_SECRET # Same as above Key Secret
aws configure set region $AWS_REGION 
aws configure set output json
echo "AWS CLI configured with provided credentials and region."
aws configure list # lists all the AWS confiuration values

