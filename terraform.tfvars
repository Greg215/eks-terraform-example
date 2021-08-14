name               = "greg-eks-demo"
vpc_cidr           = "172.31.208.0/22"
key_name           = "devops-training"
kubernetes_version = "1.19"

route53_zone_id = "Z07374591FC76OBQXEXUL"
domian          = "training.visiontech.com.sg"
image_id        = "ami-0afeae4543435bb1b"

instance_type = "t2.medium"
min_size      = 3
max_size      = 5

aws-load-balancer-ssl-cert-arn = "arn:aws:acm:ap-southeast-1:545573948854:certificate/9e9ef1d3-1913-419f-9a9d-72e4c96acfc4"