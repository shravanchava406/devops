ehco "Initializing environment variables"
source /Users/shrushra/Desktop/devops/AWS/.env

echo "Creating Key Pairs"
aws ec2 create-key-pair --key-name $AWS_EC2_KEY_PAIR_NAME --query 'KeyMaterial' --output text > $AWS_EC2_KEY_PAIR_NAME.pem

echo "Updating permissions on .pem file"
chmod 400 $AWS_EC2_KEY_PAIR_NAME.pem # Used this to update the permissions on .pem file to make it visible only to current logged in user.

echo "Listing the details for newly generated key pairs"
aws ec2 describe-key-pairs --key-name $AWS_EC2_KEY_PAIR_NAME 
