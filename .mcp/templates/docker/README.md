# Docker Deployment Templates

**Sacred containerization templates for Hermetic deployment**

---

## 📁 Directory Structure

```
docker/
├── node/               # Node.js applications
│   ├── Dockerfile
│   └── docker-compose.yml
├── python/             # Python applications (FastAPI/Flask/Django)
│   └── Dockerfile
├── go/                 # Go applications (coming soon)
├── fullstack/          # Full-stack applications
│   ├── docker-compose.yml
│   └── nginx.conf
└── README.md
```

---

## 🚀 Quick Start

### 1. Node.js Application

```bash
# Copy template to your project
cp ~/.mcp/templates/docker/node/* /path/to/your/project/

# Create .env file
echo "DATABASE_URL=postgresql://user:pass@db:5432/dbname" > .env
echo "API_KEY=your-api-key" >> .env

# Build and run
docker-compose up -d

# Check logs
docker-compose logs -f

# Stop
docker-compose down
```

### 2. Python Application

```bash
# Copy template
cp ~/.mcp/templates/docker/python/Dockerfile /path/to/your/project/

# Create requirements.txt if not exists
pip freeze > requirements.txt

# Build image
docker build -t my-python-app .

# Run container
docker run -d -p 8000:8000 my-python-app
```

### 3. Full-Stack Application

```bash
# Copy template
cp ~/.mcp/templates/docker/fullstack/* /path/to/your/project/

# Project structure should be:
# project/
# ├── frontend/
# │   └── Dockerfile
# ├── backend/
# │   └── Dockerfile
# ├── db/
# │   └── init.sql
# ├── nginx/
# │   └── nginx.conf
# ├── docker-compose.yml
# └── .env

# Create .env
cat > .env << EOF
DB_USER=postgres
DB_PASSWORD=securepassword
DB_NAME=appdb
JWT_SECRET=your-jwt-secret
EOF

# Build and run
docker-compose up -d

# Access:
# - Frontend: http://localhost
# - Backend API: http://localhost/api
# - Database: localhost:5432
```

---

## 🛠️ Customization Guide

### Dockerfile Best Practices

**Multi-stage builds** - Reduce final image size
```dockerfile
FROM node:20-alpine AS builder
# ... build steps ...
FROM node:20-alpine
# ... copy from builder ...
```

**Non-root user** - Security best practice
```dockerfile
RUN adduser -S appuser -u 1001
USER appuser
```

**Health checks** - Container orchestration
```dockerfile
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:3000/health || exit 1
```

**Layer optimization** - Cache dependencies
```dockerfile
# Copy package.json first (better caching)
COPY package*.json ./
RUN npm install

# Then copy code
COPY . .
```

### docker-compose.yml Features

**Environment variables**
```yaml
environment:
  - NODE_ENV=production
env_file:
  - .env
```

**Volume persistence**
```yaml
volumes:
  - postgres-data:/var/lib/postgresql/data
```

**Service dependencies**
```yaml
depends_on:
  db:
    condition: service_healthy
```

**Health checks**
```yaml
healthcheck:
  test: ["CMD-SHELL", "pg_isready -U postgres"]
  interval: 10s
```

**Networks**
```yaml
networks:
  - app-network
```

---

## 🔧 Common Commands

### Build & Run
```bash
# Build images
docker-compose build

# Start services
docker-compose up -d

# View logs
docker-compose logs -f [service]

# Stop services
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

### Management
```bash
# List running containers
docker ps

# Execute command in container
docker-compose exec app sh

# View logs
docker-compose logs -f app

# Restart service
docker-compose restart app

# Scale service
docker-compose up -d --scale app=3
```

### Cleanup
```bash
# Remove stopped containers
docker container prune

# Remove unused images
docker image prune

# Remove unused volumes
docker volume prune

# Full cleanup
docker system prune -a
```

---

## 🚢 Deployment Workflows

### Local Development
```bash
# 1. Build
docker-compose build

# 2. Run
docker-compose up -d

# 3. Test
docker-compose exec app npm test

# 4. Stop
docker-compose down
```

### Production Deployment
```bash
# 1. Build production images
docker-compose -f docker-compose.prod.yml build

# 2. Tag images
docker tag app:latest registry.example.com/app:v1.0.0

# 3. Push to registry
docker push registry.example.com/app:v1.0.0

# 4. Deploy to server
ssh server "docker pull registry.example.com/app:v1.0.0"
ssh server "docker-compose up -d"
```

### CI/CD Integration
```yaml
# Example GitHub Actions workflow
name: Build and Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Build Docker image
        run: docker build -t app:latest .

      - name: Push to registry
        run: |
          docker tag app:latest ${{ secrets.REGISTRY }}/app:latest
          docker push ${{ secrets.REGISTRY }}/app:latest

      - name: Deploy
        run: ssh ${{ secrets.SERVER }} "docker-compose up -d"
```

---

## 🔐 Security Best Practices

1. **Non-root user** - Always run containers as non-root
2. **Secrets management** - Use Docker secrets or env files (never commit)
3. **Image scanning** - Scan for vulnerabilities
4. **Minimal base images** - Use alpine variants
5. **Read-only filesystem** - When possible
6. **Resource limits** - Set memory/CPU limits
7. **Network isolation** - Use internal networks
8. **Regular updates** - Keep base images updated

---

## 📊 Monitoring & Logging

### Health Monitoring
```bash
# Check container health
docker ps --format "table {{.Names}}\t{{.Status}}"

# Detailed health
docker inspect --format='{{json .State.Health}}' container_name
```

### Logs
```bash
# Follow logs
docker-compose logs -f

# Last 100 lines
docker-compose logs --tail=100

# Specific service
docker-compose logs -f app

# Save logs to file
docker-compose logs > app-logs.txt
```

### Resource Usage
```bash
# View resource usage
docker stats

# Specific container
docker stats container_name
```

---

## 🎯 Next Steps

**For your project:**
1. Choose appropriate template
2. Customize Dockerfile for your stack
3. Configure docker-compose.yml
4. Set up environment variables
5. Test locally
6. Deploy to production

**Integration with deployment system:**
- Use `/deploy-docker` command (coming soon)
- Integrate with GitHub Actions
- Set up n8n workflows for automation
- Monitor with logging/alerting

---

## 📚 Resources

- [Docker Documentation](https://docs.docker.com)
- [Docker Compose Reference](https://docs.docker.com/compose/compose-file/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Multi-stage builds](https://docs.docker.com/build/building/multi-stage/)

---

*"Containerize with consciousness. Every layer serves a purpose."*

**— Hermetic Ormus**
