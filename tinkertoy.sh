#!/usr/bin/env sh

SCRIPT_NAME=$(basename $0 .sh)
SCRIPT_DIR=$(dirname $0)

ECR_REPO_NAME="tinkertoy"
ECR_IMAGE_NAME="tinkertoy"

AWS_REGION="us-east-1"
AWS_ACCOUNT="444173712702"

DOCKER_USERNAME="gaborkorodi"

run() {
  cd $SCRIPT_DIR
  uvicorn app:app --reload --port 9001 #--host 0.0.0.0 --port 82
}

build() {
  cd $SCRIPT_DIR
  docker build . --tag $ECR_IMAGE_NAME:latest --tag $ECR_IMAGE_NAME:$(date +%s)
}

up() {
  cd $SCRIPT_DIR
  docker run -it --rm --name "${ECR_IMAGE_NAME}-app" --publish "80:80" $ECR_IMAGE_NAME:latest
}

dockerpush() {
  docker login --username $DOCKER_USERNAME #password is in ~/.docker/.hub_token
  docker tag $ECR_IMAGE_NAME:latest $DOCKER_USERNAME/$ECR_IMAGE_NAME:latest
  docker push $DOCKER_USERNAME/$ECR_IMAGE_NAME:latest
}

awspush() {
  # Create a repositoy, just once
  #aws ecr create-repository --repository-name $ECR_NAME --region region
  
  #docker images --filter reference=$ECR_NAME

  #docker buildx build --platform=linux/amd64 -t <image-name> .




  set -x
  AWS_REPO_URI=$(aws ecr describe-repositories | jq -r '.repositories[] | .repositoryUri') #[--repository-names <value>]
  docker tag $ECR_IMAGE_NAME $AWS_REPO_URI
  AWS_REPO_BASE=$(echo "${AWS_REPO_URI}" | cut -d"/" -f 1)

  aws ecr get-login-password --region $AWS_REGION > /tmp/aws_ecr_login_password.txt
  cat /tmp/aws_ecr_login_password.txt | docker login -u AWS --password-stdin $AWS_REPO_BASE

  docker push $AWS_REPO_URI
  set +x
}

awscleanup() {
  # delete the repository so you are not charged for image storage.
  aws ecr delete-repository --repository-name $ECR_REPO_NAME --region $AWS_REGION --force
}

$*