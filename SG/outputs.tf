output "SG_id_manager" {
  value = aws_security_group.manager.id
}

output "SG_id_worker" {
  value = aws_security_group.worker.id
}

