# Vestibulize - Docker Setup

Este projeto inclui configuração completa do Docker para desenvolvimento e produção.

## Estrutura

- **Backend**: Spring Boot API com MySQL
- **Frontend**: React/Vite com Nginx
- **Database**: MySQL 8.0

## Pré-requisitos

- Docker
- Docker Compose

## Como usar

### 1. Desenvolvimento

```bash
# Construir e iniciar todos os serviços
docker-compose up --build

# Executar em background
docker-compose up -d --build

# Ver logs
docker-compose logs -f

# Parar todos os serviços
docker-compose down
```

### 2. Apenas o banco de dados

```bash
# Iniciar apenas o MySQL
docker-compose up mysql

# Conectar ao banco
docker exec -it vestibulize-mysql mysql -u vestibulize -p tg_vestibulize
```

### 3. Rebuild de um serviço específico

```bash
# Rebuild do backend
docker-compose up --build backend

# Rebuild do frontend
docker-compose up --build frontend
```

## URLs de Acesso

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8080/v1
- **MySQL**: localhost:3306

## Variáveis de Ambiente

### Backend
- `SPRING_PROFILES_ACTIVE=docker`
- `MYSQL_USER=vestibulize`
- `MYSQL_PASSWORD=vestibulize123`
- `JWT_SECRET=mySecretKey123456789012345678901234567890`

### Frontend
- `VITE_API_URL=http://localhost:8080/v1`

### MySQL
- `MYSQL_ROOT_PASSWORD=root`
- `MYSQL_DATABASE=tg_vestibulize`

## Comandos Úteis

```bash
# Limpar volumes (CUIDADO: apaga dados do banco)
docker-compose down -v

# Ver status dos containers
docker-compose ps

# Executar comandos no container
docker exec -it vestibulize-backend bash
docker exec -it vestibulize-frontend sh

# Ver logs de um serviço específico
docker-compose logs backend
docker-compose logs frontend
docker-compose logs mysql
```

## Health Checks

Todos os serviços incluem health checks:

- **MySQL**: `mysqladmin ping`
- **Backend**: `curl http://localhost:8080/v1/actuator/health`
- **Frontend**: `wget http://localhost:3000/health`

## Troubleshooting

### Porta já em uso
```bash
# Verificar processos usando as portas
lsof -i :3000
lsof -i :8080
lsof -i :3306

# Parar processos se necessário
kill -9 <PID>
```

### Problemas de build
```bash
# Limpar cache do Docker
docker system prune -a

# Rebuild sem cache
docker-compose build --no-cache
```

### Problemas de banco
```bash
# Resetar banco de dados
docker-compose down -v
docker-compose up mysql
```

## Docker Hub - Publicar Imagens

### 1. Preparação

```bash
# Fazer login no Docker Hub
docker login

# Criar conta no Docker Hub se não tiver: https://hub.docker.com
```

### 2. Build e Push das Imagens

```bash
# Usar o script automatizado (recomendado)
./docker-push.sh seu-usuario-dockerhub v1.0.0

# Ou fazer manualmente:
docker build -t seu-usuario-dockerhub/vestibulize-back-api:latest ./back-api
docker build -t seu-usuario-dockerhub/vestibulize-front-web:latest ./front-web

docker push seu-usuario-dockerhub/vestibulize-back-api:latest
docker push seu-usuario-dockerhub/vestibulize-front-web:latest
```

### 3. Usar Imagens do Docker Hub

```bash
# Usar o docker-compose de produção
cp .env.prod.example .env.prod
# Editar .env.prod com suas configurações

docker-compose -f docker-compose.prod.yml --env-file .env.prod up -d
```

### 4. Comandos Úteis para Docker Hub

```bash
# Listar suas imagens
docker images | grep seu-usuario-dockerhub

# Remover imagens locais
docker rmi seu-usuario-dockerhub/vestibulize-back-api:latest
docker rmi seu-usuario-dockerhub/vestibulize-front-web:latest

# Baixar imagens do Docker Hub
docker pull seu-usuario-dockerhub/vestibulize-back-api:latest
docker pull seu-usuario-dockerhub/vestibulize-front-web:latest
```

## Produção

Para produção, considere:

1. Usar secrets do Docker para senhas
2. Configurar SSL/TLS
3. Usar um reverse proxy (nginx/traefik)
4. Configurar backup automático do banco
5. Usar variáveis de ambiente seguras
6. Usar imagens do Docker Hub para deploy
