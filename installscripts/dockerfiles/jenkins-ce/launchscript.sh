#!/bin/bash
spin_wheel()
{
    RED=$'\033[0;31m'
    GREEN=$'\033[0;32m'
    NC=$'\033[0m'

    pid=$1 # Process Id of the previous running command
    message=$2
    spin='-\|/'
    printf "\r%s...." "$message"
    i=0

    while ps -p "$pid" > /dev/null
    do
        #echo $pid $i
        i=$(( (i+1) %4 ))
        printf "\r%s%s....%s" "${GREEN}" "$message" "${spin:$i:1}"
        sleep .05
    done

    wait "$pid"
    exitcode=$?
    if [ $exitcode -gt 0 ]
    then
        printf "\r%s%s....Failed%s\n" "${RED}" "$message" "${NC}"
        exit
    else
        printf "\r%s%s....Completed%s\n" "${GREEN}" "$message" "${NC}"

    fi
}

# Check if docker with same name exists. If yes, stop and remove the docker container.
if sudo docker ps -a | grep -i jenkins-server &> /dev/null ; then
  echo "Detected a container with name: jenkins-server. Deleting it..."
  sudo docker stop jenkins-server &> /dev/null &
  spin_wheel $! "Stopping existing Jenkins Docker"
  sudo docker rm jenkins-server &> /dev/null &
  spin_wheel $! "Removing existing Jenkins Docker"
fi

# Check if docker volume exists. If yes, remove the docker volume.
if sudo docker volume inspect jenkins-volume &> /dev/null ; then
  echo "Detected a volume with name: jenkins-volume. Deleting it..."
  sudo docker volume rm jenkins-volume &> /dev/null &
fi

# Building the custom docker image from the jenkins-ce base image
cd ../../../installscripts || exit
passwd=$(date | md5sum | cut -d ' ' -f1)
dockerhub='jazzserverless'
dockertag='1.0.0'
docker pull "$dockerhub"/jazzoss-jenkins:"$dockertag"

# Create the volume that we host the jenkins_home dir on dockerhost.
sudo docker volume create jenkins-volume &> /dev/null &
spin_wheel $! "Creating the Jenkins volume"

# Running the custom image
sudo docker run -d --name jenkins-server -p 8081:8080 -v jenkins-volume:/var/jenkins_home -e JENKINS_USER='admin' -e JENKINS_PASS="$passwd" "$dockerhub"/jazzoss-jenkins:$dockertag

# Wainting for the container to spin up
sleep 60
echo "initialPassword is: $passwd"

# Grab the variables
ip=$(curl -sL http://169.254.169.254/latest/meta-data/public-ipv4)
mac=$(curl -sL http://169.254.169.254/latest/meta-data/network/interfaces/macs)
security_groups=$(curl -sL http://169.254.169.254/latest/meta-data/network/interfaces/macs/"${mac%/}"/security-group-ids)
subnet_id=$(curl -sL http://169.254.169.254/latest/meta-data/network/interfaces/macs/"${mac%/}"/subnet-id)

# Values to be passed to parameter list
jenkins_server_elb="$ip:8081"
jenkins_username="admin"
jenkins_passwd="$passwd"
jenkins_server_public_ip="$ip"
jenkins_server_ssh_login="root"
jenkins_server_ssh_port="2200"
jenkins_server_security_group="$security_groups"
jenkins_server_subnet="$subnet_id"

# Print the values to a temp file to be read from calling python script
{ echo "$jenkins_server_elb"; echo "$jenkins_username"; echo "$jenkins_passwd"; \
 echo "$jenkins_server_public_ip"; echo "$jenkins_server_ssh_login"; echo "$jenkins_server_ssh_port"; \
 echo "$jenkins_server_security_group"; echo "$jenkins_server_subnet"; } > dockerfiles/jenkins-ce/docker_jenkins_vars
