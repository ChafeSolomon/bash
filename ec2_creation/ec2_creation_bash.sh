!/bin/bash
aws_setup_secrets() {
    aws_access_key_id=''
    aws_secret_access_key=''

    if [[ $(ls ./.aws) ]]; then
        echo '.aws exists skipping'
        
    else
        mkdir ./.aws
        echo 'creating secrets'
        echo -e "[default]\naws_access_key_id = $aws_access_key_id\naws_secret_access_key = $aws_secret_access_key" > ./.aws/credentials
        echo -e "[default]\nregion = us-east-1" > ./.aws/config
        aws configure
    fi

}
#Function for installing awscli
aws_cli_installation() {

    aws help > /dev/null
    bash_success_code="$?"

    if [ $bash_success_code -eq 0 ]; then
        echo 'aws cli is currently installed. skipping'
        
    else
        echo 'aws cli is not installed... installing'
        apt install unzip
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip ./awscliv2.zip
        ./aws/install
        ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update

    fi
       
}
# Choose your region
aws_cli_regional_selection(){

    regional_options=('ap-south-1' 'eu-north-1' 'eu-west-3' 'eu-west-2' 'eu-west-1' 'ap-northeast-3' 'ap-northeast-2' 'ap-northeast-1' 'ca-central-1' 'sa-east-1' 'ap-southeast-1' 'ap-southeast-2' 'eu-central-1' 'us-east-1' 'us-east-2' 'us-west-1' 'us-west-2')
    regional_selection="."

    # Until regional selection is the same as a string in the regional option.
    until [[ " ${regional_options[*]} " =~ "${regional_selection} " ]]; do
        echo "${regional_options[*]}"
        read -p "From the list of regions above which region would you like to use? " regional_selection
    done   
    


    # Launch Instance
    aws ec2 run-instances --region $regional_selection --image-id ami-04a0ae173da5807d3 --instance-type t2.micro --key-name bash_key --user-data file:///$user_data_dir > ./instance_information
}

aws_setup_secrets
aws_cli_installation
read -r "What is the userdata script dir" user_data_dir
aws_cli_regional_selection


