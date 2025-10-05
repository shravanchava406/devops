# Step 1: Download the AWS CLI v2 package for macOS
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"

# Step 2: Install the AWS CLI v2 package in the root directory (/ specifies the root directory)
sudo installer -pkg AWSCLIV2.pkg -target /

# Step 3: Verify the installation
echo "Verifying AWS CLI installation..."
echo "--------------------------------"
echo "AWS CLI INSTALLATION PATH:"
which aws
echo "--------------------------------"
echo "AWS CLI VERSION:"
aws --version