terraform {
  backend "s3" {
    profile                 = "gaurav-dev"
    bucket                  = "gaurav-terraform"
    key                     = "dev/services/symmetrical-spork"
    region                  = "us-east-1"
    encrypt                 = true
  }
}
