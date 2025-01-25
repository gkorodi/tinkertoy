
# Using Terraform

```sh

# Get help
terraform -help

# Get help for specific command
terraform -help plan

# You should have at least one file here.
ls -al main.tf

# Show plan against the current configuration
terraform plan -out=tinkertoy.plan

# This is the Terraform DevOps lifecycle
terraform init
terraform plan
terraform apply

# Verify that the container is created and running
docker ps

# Stop the container and delete everything that was created
terraform destroy
```

