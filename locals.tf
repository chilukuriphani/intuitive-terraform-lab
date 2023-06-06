locals {
  multiple_instances = {
    one = {
      instance_type     = "t3.micro"
      availability_zone = data.aws_availability_zones.available.names[0]
      subnet_id         = element(module.lab-vpc.subnet_id, 0)
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp3"
          throughput  = 200
          volume_size = 50
          tags = {
            Name = "my-root-block"
          }
        }
      ]
    }
    two = {
      instance_type     = "t3.small"
      availability_zone = data.aws_availability_zones.available.names[1]
      subnet_id         = element(module.lab-vpc.subnet_id, 1)
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 100
        }
      ]
    }
    
      }
}
