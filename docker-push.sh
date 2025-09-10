#!/bin/bash

# Script para build e push das imagens para Docker Hub
# Uso: ./docker-push.sh [DOCKER_USERNAME] [VERSION]

set -e
docker login

# Configurações
DOCKER_USERNAME=${1:-"gabrielrenato3"}
VERSION=${2:-"latest"}
PROJECT_NAME="vestibulize"

echo "🐳 Building and pushing images to Docker Hub..."
echo "Username: $DOCKER_USERNAME"
echo "Version: $VERSION"
echo ""

# Verificar se o login foi bem-sucedido
echo "✅ Docker login realizado com sucesso!"

# Build das imagens
echo "🔨 Building backend image..."
docker build -t $DOCKER_USERNAME/vestibulize-back-api:$VERSION ./back-api
docker build -t $DOCKER_USERNAME/vestibulize-back-api:latest ./back-api

echo "🔨 Building frontend image..."
docker build -t $DOCKER_USERNAME/vestibulize-front-web:$VERSION ./front-web
docker build -t $DOCKER_USERNAME/vestibulize-front-web:latest ./front-web

# Push das imagens
echo "📤 Pushing backend image..."
docker push $DOCKER_USERNAME/vestibulize-back-api:$VERSION
docker push $DOCKER_USERNAME/vestibulize-back-api:latest

echo "📤 Pushing frontend image..."
docker push $DOCKER_USERNAME/vestibulize-front-web:$VERSION
docker push $DOCKER_USERNAME/vestibulize-front-web:latest

echo ""
echo "✅ Images pushed successfully!"
echo ""
echo "📋 Image URLs:"
echo "Backend:  docker.io/$DOCKER_USERNAME/vestibulize-back-api:$VERSION"
echo "Frontend: docker.io/$DOCKER_USERNAME/vestibulize-front-web:$VERSION"
echo ""
echo "🚀 To use these images, update your docker-compose.yml with:"
echo "  backend:"
echo "    image: $DOCKER_USERNAME/vestibulize-back-api:$VERSION"
echo "  frontend:"
echo "    image: $DOCKER_USERNAME/vestibulize-front-web:$VERSION"
