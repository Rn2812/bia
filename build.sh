#!/bin/bash
set -e

AWS_REGION="us-east-1"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

ECR_REPOSITORY="bia"
ECR_REGISTRY="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
ECR_URI="${ECR_REGISTRY}/${ECR_REPOSITORY}"

echo "Conta AWS: ${ACCOUNT_ID}"
echo "Região: ${AWS_REGION}"
echo "ECR URI: ${ECR_URI}"

echo "Validando repositório ECR..."
aws ecr describe-repositories \
  --repository-names "${ECR_REPOSITORY}" \
  --region "${AWS_REGION}"

echo "Login no ECR..."
aws ecr get-login-password --region "${AWS_REGION}" | \
docker login --username AWS --password-stdin "${ECR_REGISTRY}"

echo "Build da imagem Docker..."
docker build -t "${ECR_REPOSITORY}:latest" .

echo "Tag da imagem..."
docker tag "${ECR_REPOSITORY}:latest" "${ECR_URI}:latest"

echo "Push para o ECR..."
docker push "${ECR_URI}:latest"

echo "Build e push finalizados com sucesso."
echo "Imagem publicada em: ${ECR_URI}:latest"
