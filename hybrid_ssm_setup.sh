#!/bin/bash

information_gathering(){
    declare -g registration_code
    declare -g id_code
    declare -g region
    read -p "Please input the Registration Code: " registration_code
    read -p "Please input the Registration id: " id_code
    read -p "What region will this be going to? : " region
}

run_script(){
    mkdir /tmp/ssm
    curl https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb -o /tmp/ssm/amazon-ssm-agent.deb
    sudo dpkg -i /tmp/ssm/amazon-ssm-agent.deb
    sudo service amazon-ssm-agent stop
    sudo -E amazon-ssm-agent -register -code "$registration_code" -id "$id_code" -region "$region" 
    sudo service amazon-ssm-agent start
}

information_gathering
run_script