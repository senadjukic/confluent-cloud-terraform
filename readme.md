# Terraform Confluent Cloud Demo

## Prerequisites
1. Check if you have CC Account
2. Check if you have Terraform https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform
3. Check if you have Confluent CLI
4. Follow https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/guides/sample-project#create-a-cloud-api-key
5. Use basic-kafka-acls (https://github.com/confluentinc/terraform-provider-confluent/tree/master/examples/configurations/basic-kafka-acls) or the artifacts under ./terraform in this repo
6. create terraform.vars file with your credentials
6. terraform init
7. terraform apply

** Wanna skip the inputs? **
```
touch terraform.tfvars

confluent_cloud_api_key = "(see CC settings)"
confluent_cloud_api_secret = "(see CC settings)"
environment_name = "terraform_demo"
stream_governance_cloud_provider = "AWS"
stream_governance_region = "eu-central-1"
stream_governance_package = "ADVANCED"
cluster_cloud_provider = "AWS"
cluster_cloud_region = "eu-central-1"
cluster_name = "test_cluster"
topic_name = "prod.domain1.sample-topic"
schema_namespace = "test-namespace"
record_name = "test-record-name"
```

** Display also sensitive fields **
```for i in $(terraform output | cut -d "=" -f1); do echo "$i = $(terraform output -raw $i)"; done```

Or simply:
```terraform output -raw resource-ids```

** Wanna see the records in the CLI? **
confluent kafka topic consume -b prod.domain1.sample-topic

** Wanna deploy faster? **
terraform apply -auto-approve

** Visualize the deployed resources **
Run and open in browser `localhost:9000`
```docker run --rm -it -p 9000:9000 -v $(pwd):/src im2nguyen/rover```