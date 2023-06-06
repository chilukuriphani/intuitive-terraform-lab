region_name = "ap-southeast-1"
tags = {
  "terraform"   = true
  "environment" = "prod"
  "application" = "lab"
}
master_prefix = "intutive"
env_prefix    = "prod"
app_prefix    = "lab"
vpc_cidr = "10.241.80.0/20"

# # Number prefixes indicate order of subnets in map. Do not change. Change to order lead to replacement of subnet resource
vpc_subnet_list = {
  "lab" = {
    "a" = "10.240.16.0/28"
    "b" = "10.240.16.16/28"
  }
}
vpc_tags             = null
#### EC2 #####
lab_instances = [
  {
    "instance_name" : "terraform-lab-1",
    "no_of_instances" : "1",
    "zone_name" :"1a",
    "subnet_id" : "subnet-0ef0c17bf74ddd84b",
  },
    {
    "instance_name" : "terraform-lab-2",
    "no_of_instances" : "1",
     "zone_name" :"1b",
    "subnet_id" : "subnet-0c619ce14e4ba50ae",
  }
]
#### S3 #####
lifecycle_rules = [{
  id     = "TRANSITION-REPORTS-TO-IA-30D"
  days   = "30"
  sclass = "STANDARD_IA"
  prefix = "REPORTS/"
  expire = null
  status = "Enabled"
  },
  {
    id     = "TRANSITION-REPORTS-TO-GLACIER-90D-DELETE-7Y"
    days   = "90"
    sclass = "DEEP_ARCHIVE"
    prefix = "REPORTS/"
    expire = 2555
    status = "Enabled"
  }
]