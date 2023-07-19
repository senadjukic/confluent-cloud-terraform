# Terraform Confluent Cloud Demo

## Prerequisites
1. Check if you have CC Account
2. Check if you have Terraform https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform
3. Check if you have Confluent CLI

## Run the demo
1. Follow https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/guides/sample-project#create-a-cloud-api-key
2. Use basic-kafka-acls (https://github.com/confluentinc/terraform-provider-confluent/tree/master/examples/configurations/basic-kafka-acls) or the artifacts under ./terraform in this repo
3. create terraform.vars file with your credentials

```
touch terraform.tfvars

confluent_cloud_api_key = "{Cloud API Key}"
confluent_cloud_api_secret = "{Cloud API Key Secret}"
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

4. `terraform init`
5. `terraform apply -auto-approve`


**Display also sensitive fields** <br>
```for i in $(terraform output | cut -d "=" -f1); do echo "$i = $(terraform output -raw $i)"; done```

Or simply:
```terraform output -raw resource-ids```

**Monitoring**

1. Modify ./metrics/metrics.yml to add your CC API Key + CC API Key Secret and specify your resource IDs
2. Run `docker compose -f ./metrics/docker-compose.yaml up -d`
3. Open Browser Prometheus `localhost:9090` and Grafana `localhost:3000` with `admin` & `password`

**Visualize the deployed resources** <br>
Run `docker run --rm -it -p 9000:9000 -v $(pwd):/src im2nguyen/rover` <br> and open in browser `localhost:9000` <br>


**Terraform Sentinel Policies & OPA**
To inspect your TF artifacts during CI/CD pipeline stages, add: 
* https://github.com/confluentinc/policy-library-confluent-terraform
* https://github.com/mcolomerc/terraform-confluent-opa-sample/tree/main

**Next steps:**
- Add sample data over the ./python-producer
- Add a self-managed connector that reads from a DB and pushes data to Confluent Cloud via ./self-managed-connector
- Add a fully-managed connector over the CC UI

