variable "credentials" {
  description = "Stefan Credentials"
  default     = "./keys/terraform-keys.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "global-env-447720-j9"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default     = "europe-west2" # europe-west1-b does not support this. only europe-west2, 4, 6 will work for making bigquery dataset out of this.
  # source: https://stackoverflow.com/questions/62679150/bigquery-data-transfer-location-not-supported-in-command-line-but-works-in-gc
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default     = "europe-west2"
}

variable "bq_dataset_name" {
  description = "BigQuery Dataset Name for EMS"
  #Update the below to what you want your dataset to be called
  default     = "zoom_cap_bq"
}

variable "gcs_bucket_name" {
  description = "Storage Bucket for EMS"
  #Update the below to a unique bucket name
  default     = "zoom_cap_gcs"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

