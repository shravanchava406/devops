echo "Initializing environment variables"
source /Users/shrushra/Desktop/devops/AWS/.env

echo "Creating EC2 Instance with all the required Parameters"

aws ec2 run-instances --image-id $AWS_EC2_US_EAST_1_AMI_BASE_LINUX_X86_64_ID --count $AWS_EC2_INSTANCE_COUNT --instance-type $AWS_EC2_INSTANCE_TYPE --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$AWS_EC2_INSTANCE_NAME}]" --key-name $AWS_EC2_KEY_PAIR_NAME --security-group-ids $AWS_EC2_SECURITY_GROUPS