provider "aws" {
  profile = "gaurav-dev"
  region  = "us-east-1"
}

provider "aws" {
  profile = "gaurav-dev"
  region  = "us-east-1"
  alias   = "r53"
}
