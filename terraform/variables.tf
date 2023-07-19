variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (also referred as Cloud API ID)"
  type        = string
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}

variable "environment_name" {
  description = "Name of the Confluent Cloud environment"
  type        = string
}

variable "stream_governance_cloud_provider" {
  description = "Name of the CSP for stream governance"
  type        = string
}

variable "stream_governance_region" {
  description = "Name of the cloud region for stream governance"
  type        = string
}

variable "stream_governance_package" {
  description = "Name of the stream governance package"
  type        = string
}

variable "cluster_cloud_provider" {
  description = "Name of the Confluent Cloud CSP"
  type        = string
}

variable "cluster_cloud_region" {
  description = "Name of the Confluent Cloud cluster region name"
  type        = string
}

variable "cluster_name" {
  description = "Name of the Confluent Cloud cluster in the environment"
  type        = string
}

variable "topic_name" {
  description = "Name of the topic on the cluster"
  type        = string
}

variable "schema_namespace" {
  description = "The namespace of the schema"
  type        = string
}

variable "record_name" {
  description = "The name of the record in the schema"
  type        = string
}