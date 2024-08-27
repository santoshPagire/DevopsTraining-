output "vpc_id" {
  value = module.vpc.vpc_id
}

output "alb_security_group_id" {
  value = module.security_groups.alb_security_group_id
}

output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}
