set -e
docker login

DOCKER_USERNAME=${1:-"vestibulize"}
VERSION=${2:-"latest"}
PROJECT_NAME="vestibulize"

echo "Username: $DOCKER_USERNAME"
echo "Version: $VERSION"
echo ""

# Verificar se o login foi bem-sucedido
echo "Docker login realizado com sucesso!"

# Build das imagens
echo "Building backend image..."
docker build -t $DOCKER_USERNAME/back-api:$VERSION ../back-api
docker build -t $DOCKER_USERNAME/back-api:latest ../back-api

echo "Building frontend image..."
docker build --build-arg VITE_API_URL=http://localhost:8080 -t $DOCKER_USERNAME/front-web:$VERSION ../front-web
docker build --build-arg VITE_API_URL=http://localhost:8080 -t $DOCKER_USERNAME/front-web:latest ../front-web

# Push das imagens
echo "Pushing backend image..."
docker push $DOCKER_USERNAME/back-api:$VERSION
docker push $DOCKER_USERNAME/back-api:latest

echo "Pushing frontend image..."
docker push $DOCKER_USERNAME/front-web:$VERSION
docker push $DOCKER_USERNAME/front-web:latest

echo ""
echo "Images pushed successfully!"
echo ""
echo "Image URLs:"
echo "Backend:  docker.io/$DOCKER_USERNAME/back-api:$VERSION"
echo "Frontend: docker.io/$DOCKER_USERNAME/front-web:$VERSION"
echo ""
echo "To use these images, update your docker-compose.yml with:"
echo "  backend:"
echo "    image: $DOCKER_USERNAME/back-api:$VERSION"
echo "  frontend:"
echo "    image: $DOCKER_USERNAME/front-web:$VERSION"
