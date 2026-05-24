#!/bin/bash
set -e

AWS_REGION="us-east-1"
ECS_CLUSTER="bia-cluster"
ECS_SERVICE="bia-service"
ECS_TASK_FAMILY="bia-task"

echo "Atualizando service ECS..."
echo "Cluster: ${ECS_CLUSTER}"
echo "Service: ${ECS_SERVICE}"
echo "Task Definition: ${ECS_TASK_FAMILY}"

aws ecs update-service \
  --cluster "${ECS_CLUSTER}" \
  --service "${ECS_SERVICE}" \
  --task-definition "${ECS_TASK_FAMILY}" \
  --force-new-deployment \
  --region "${AWS_REGION}"

echo "Deploy solicitado com sucesso."
