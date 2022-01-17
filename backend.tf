#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: [% DATE  # 2020-08-21 10:23:27 +0100 (Fri, 21 Aug 2020) %]
#
#  https://github.com/HariSekhon/Terraform
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

terraform {

  # ============================
  # Newbies get this by default:
  #
  #default backend
  #backend "local" {
  #  path = "./terraform.tfstate"
  #}

  # Teams need one of the following for shared state:

  # ===========
  # Cloud Pros:
  #
  # =============
  # Google Cloud:
  #
  # XXX: remember to enable Object Versioning on this GCS bucket for state recovery:
  #
  #   https://cloud.google.com/storage/docs/object-versioning
  #
  #   gsutil versioning set on gs://$GOOGLE_PROJECT_ID-productiontf-state
  #backend "gcs" {
  #  bucket = "NAME-production-tf-state"   # XXX: EDIT
  #  prefix = "terraform/state/production" # <prefix>/<name>.tfstate
  #}

  # ====================
  # Amazon Web Services:
  #
  # XXX: remember to enable Bucket Versioning on this S3 bucket for state recovery:
  #
  #   https://docs.aws.amazon.com/AmazonS3/latest/user-guide/enable-versioning.html
  #
  # IAM permissions needed:
  #
  #   https://www.terraform.io/docs/backends/types/s3.html#s3-bucket-permissions
  #
  #backend "s3" {
  #  bucket = "mybucket" # XXX: EDIT
  #  key    = "path/to/my/key"
  #  region = "eu-west-1"
  #  encrypt = true
  #  # XXX: EDIT - set DynamoDB table name and configure for locking:
  #  #
  #  #  https://www.terraform.io/docs/backends/types/s3.html#dynamodb-state-locking
  #  #
  #  dynamodb_table = "mytable"
  #}

  # ================
  # Terraform Cloud:
  #
  #backend "remote" {
  #  hostname = "app.terraform.io"  # for Terraform Enterprise adjust this to your on-prem installation address
  #  organization = "mycompany"  # XXX: EDIT
  #
  #  workspaces {
  #    # XXX: EDIT
  #    # single workspace
  #    name = "my-app-prod"
  #    # or multiple workspaces - prompts with a list of prefix matching workspaces at runtime
  #    prefix = "my-app-"
  #  }
  #}
}
