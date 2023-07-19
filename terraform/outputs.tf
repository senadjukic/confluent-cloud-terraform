output "environment_id" {
  value = confluent_environment.environment.id
  sensitive = true
}

output "schema_registry_cluster_rest_endpoint" {
  value = confluent_schema_registry_cluster.streamgov.rest_endpoint
  sensitive = true
} 

output "schema_registry_cluster_api_key" {
  value = confluent_api_key.env-manager-schema-registry-api-key.id
  sensitive = true
}

output "schema_registry_cluster_api_key_secret" {
  value = confluent_api_key.env-manager-schema-registry-api-key.secret
  sensitive = true
}     

output "cluster_id" {
  value = confluent_kafka_cluster.basic.id
  sensitive = true
}

output "cluster_bootstrap_endpoint" {
  value = confluent_kafka_cluster.basic.bootstrap_endpoint
  sensitive = true
}

output "topic_name" {
  value = confluent_kafka_topic.test-topic.topic_name
  sensitive = true
}

output "cluster_manager_id" {
  value = confluent_service_account.cluster-manager.id
  sensitive = true
}

output "cluster_manager_kafka_api_key" {
  value = confluent_api_key.cluster-manager-kafka-api-key.id
  sensitive = true
}

output "cluster_manager_kafka_api_secret" {
  value = confluent_api_key.cluster-manager-kafka-api-key.secret
  sensitive = true
}

output "producer_id" {
  value = confluent_service_account.test-producer.id
  sensitive = true
}

output "producer_kafka_api_key" {
  value = confluent_api_key.test-producer-kafka-api-key.id
  sensitive = true
}

output "producer_kafka_api_secret" {
  value = confluent_api_key.test-producer-kafka-api-key.secret
  sensitive = true
}

output "consumer_id" {
  value = confluent_service_account.test-consumer.id
  sensitive = true
}

output "consumer_kafka_api_key" {
  value = confluent_api_key.test-consumer-kafka-api-key.id
  sensitive = true
}

output "resource-ids" {
  value = <<-EOT
  Environment ID:   ${confluent_environment.environment.id}
  Kafka Cluster ID: ${confluent_kafka_cluster.basic.id}
  Kafka topic name: ${confluent_kafka_topic.test-topic.topic_name}

  Service Accounts and their Kafka API Keys (API Keys inherit the permissions granted to the owner):
  ${confluent_service_account.cluster-manager.display_name}:                     ${confluent_service_account.cluster-manager.id}
  ${confluent_service_account.cluster-manager.display_name}'s Kafka API Key:     "${confluent_api_key.cluster-manager-kafka-api-key.id}"
  ${confluent_service_account.cluster-manager.display_name}'s Kafka API Secret:  "${confluent_api_key.cluster-manager-kafka-api-key.secret}"

  ${confluent_service_account.test-producer.display_name}:                    ${confluent_service_account.test-producer.id}
  ${confluent_service_account.test-producer.display_name}'s Kafka API Key:    "${confluent_api_key.test-producer-kafka-api-key.id}"
  ${confluent_service_account.test-producer.display_name}'s Kafka API Secret: "${confluent_api_key.test-producer-kafka-api-key.secret}"

  ${confluent_service_account.test-consumer.display_name}:                    ${confluent_service_account.test-consumer.id}
  ${confluent_service_account.test-consumer.display_name}'s Kafka API Key:    "${confluent_api_key.test-consumer-kafka-api-key.id}"
  ${confluent_service_account.test-consumer.display_name}'s Kafka API Secret: "${confluent_api_key.test-consumer-kafka-api-key.secret}"

  In order to use the Confluent CLI v2 to produce and consume messages from topic '${confluent_kafka_topic.test-topic.topic_name}' using Kafka API Keys
  of ${confluent_service_account.test-producer.display_name} and ${confluent_service_account.test-consumer.display_name} service accounts
  run the following commands:

  # 1. Log in to Confluent Cloud
  $ confluent login

  # 2. Produce key-value records to topic '${confluent_kafka_topic.test-topic.topic_name}' by using ${confluent_service_account.test-producer.display_name}'s Kafka API Key
  $ confluent kafka topic produce ${confluent_kafka_topic.test-topic.topic_name} --environment ${confluent_environment.environment.id} --cluster ${confluent_kafka_cluster.basic.id} --api-key "${confluent_api_key.test-producer-kafka-api-key.id}" --api-secret "${confluent_api_key.test-producer-kafka-api-key.secret}"
$ confluent kafka topic produce ${confluent_kafka_topic.test-topic.topic_name} \
        --schema "schemas/test-schema.avsc" \
        --value-format avro \
        --schema-registry-endpoint ${confluent_schema_registry_cluster.streamgov.rest_endpoint} \
        --schema-registry-api-key "${confluent_api_key.env-manager-schema-registry-api-key.id}" \
        --schema-registry-api-secret "${confluent_api_key.env-manager-schema-registry-api-key.secret}" \
        --cluster ${confluent_kafka_cluster.basic.id} \
        --api-key "${confluent_api_key.test-producer-kafka-api-key.id}" \
        --api-secret "${confluent_api_key.test-producer-kafka-api-key.secret}" \
        --environment ${confluent_environment.environment.id}
  # Enter a few records and then press 'Ctrl-C' when you're done.
  # Sample records:
  # {"item":"pizza","amount":0.99,"customer_id":"lombardi"}
  # {"item":"pizza","amount":1.99,"customer_id":"lombardi"}
  # {"item":"ball","amount":29.99,"customer_id":"spalding"}

  # 3. Consume records from topic '${confluent_kafka_topic.test-topic.topic_name}' by using ${confluent_service_account.test-consumer.display_name}'s Kafka API Key
  $ confluent kafka topic consume ${confluent_kafka_topic.test-topic.topic_name} \
        --from-beginning \
        --value-format avro \
        --schema-registry-endpoint ${confluent_schema_registry_cluster.streamgov.rest_endpoint} \
        --schema-registry-api-key "${confluent_api_key.env-manager-schema-registry-api-key.id}" \
        --schema-registry-api-secret "${confluent_api_key.env-manager-schema-registry-api-key.secret}" \
        --cluster ${confluent_kafka_cluster.basic.id} \
        --api-key "${confluent_api_key.test-consumer-kafka-api-key.id}" \
        --api-secret "${confluent_api_key.test-consumer-kafka-api-key.secret}" \
        --environment ${confluent_environment.environment.id}
  # When you are done, press 'Ctrl-C'.
  EOT

  sensitive = true
}
