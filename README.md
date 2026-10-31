# BIA na AWS · Docker, ECR, ECS e CI/CD

Deploy da aplicação BIA (Node.js + PostgreSQL) na AWS, feito por **Rodrigo Nillo** durante a Imersão AWS & IA (maio de 2026). A aplicação base é do curso; este fork registra a parte de infraestrutura e entrega contínua.

## O que eu fiz

| Arquivo | O que faz |
|---|---|
| [`build.sh`](build.sh) | Descobre a conta AWS, valida o repositório no ECR, faz login, gera a imagem Docker e publica com a tag `latest` |
| [`deploy.sh`](deploy.sh) | Força um novo deploy do serviço `bia-service` no cluster ECS `bia-cluster` com a task definition `bia-task` |
| [`buildspec.yml`](buildspec.yml) | Pipeline do CodeBuild: login no ECR, build e push da imagem e geração do `imagedefinitions.json` para o deploy no ECS. A conta é obtida em tempo de execução (`sts get-caller-identity`), sem ID fixo no código |
| [`config/database.js`](config/database.js) | Ajuste da detecção de conexão local para o banco na rede interna da VPC e para `DB_SSL=false` |

Também testei o fluxo de desenvolvimento numa instância EC2 (commits a partir da própria máquina).

**Stack:** AWS (ECR, ECS, CodeBuild, EC2, IAM/STS) · Docker · Bash · Node.js · PostgreSQL

## Fluxo

```
git push → CodeBuild (buildspec.yml) → imagem no ECR → imagedefinitions.json → ECS atualiza o serviço
```

Execução manual, com AWS CLI configurada:

```bash
./build.sh     # build e push para o ECR
./deploy.sh    # novo deploy no ECS
```

Nenhuma credencial fica no repositório: os scripts usam o perfil da AWS CLI ou tokens temporários do STS.

---

## README original do projeto base

## Projeto base para o evento Imersão AWS & IA que irei realizar.

### Período do evento: 23/05 e 24/05/2026 (Online e ao Vivo das 9h30 às 17h30)

[>> Página de Inscrição do evento](https://org.imersaoaws.com.br/github/readme)

#### Para rodar as migrations no container ####
```
docker compose exec server bash -c 'npx sequelize db:migrate'
```

