#Setup a S3 bucket and Dynamo_DB table back-end configuration to store the state file and state lock remotely

provider "aws" {

  #Ommited the version as it is optional, terraform will download the latest
  #region = "us-east-1" #Using N.Virginia as our DC

  region = var.region

  profile = "my_aws_profile"
}

resource "aws_s3_bucket" "my_s3bucket_state" {

       bucket = "mys3bucketstate"
#       region = "us-east-1"
#       key    = "mys3bucketstate/s3bucket.tfstate"
#       dynamodb_table = "mydynamostatelock"

server_side_encryption_configuration {
        rule {
            bucket_key_enabled = true

            apply_server_side_encryption_by_default {
                kms_master_key_id = null
                sse_algorithm     = "AES256"
            }
        }
    }

    versioning {
        enabled    = true
        mfa_delete = false
    }
}

