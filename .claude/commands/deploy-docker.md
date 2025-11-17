---
description: Deploy application using Docker containers
tags: deployment, docker, containers
---

You are deploying an application using Docker. This workflow handles:
- Building Docker images
- Running containers locally or remotely
- Multi-service orchestration
- Production deployment

## Pre-Deployment Checklist

Before deploying, verify:
1. ✅ Docker is installed (check: `docker --version`)
2. ✅ docker-compose is available
3. ✅ Project has Dockerfile or docker-compose.yml
4. ✅ Environment variables configured (.env file)

## Deployment Workflow

### Step 1: Gather Information

Ask the user:
- **Deployment target**:
  - [ ] Local testing
  - [ ] Remote server (SSH)
  - [ ] Container registry (Docker Hub, etc.)
- **Application type**:
  - [ ] Single container
  - [ ] Multi-service (docker-compose)
- **Project path**: Where is the Dockerfile?

### Step 2: Prepare Configuration

Check for existing Docker files:

```bash
# Look for Docker files in project
ls -la Dockerfile docker-compose.yml .dockerignore
```

If missing, offer templates:
- Node.js: `~/.mcp/templates/docker/node/`
- Python: `~/.mcp/templates/docker/python/`
- Full-stack: `~/.mcp/templates/docker/fullstack/`

Copy template if needed:
```bash
cp ~/.mcp/templates/docker/{template}/Dockerfile ./
```

### Step 3: Build Image

**Single container:**
```bash
# Build
docker build -t {app-name}:{version} .

# View built image
docker images | grep {app-name}
```

**Multi-service:**
```bash
# Build all services
docker-compose build

# Build specific service
docker-compose build {service-name}
```

### Step 4: Test Locally

**Single container:**
```bash
# Run container
docker run -d -p {host-port}:{container-port} \
  --name {app-name} \
  --env-file .env \
  {app-name}:{version}

# Check logs
docker logs -f {app-name}

# Health check
curl http://localhost:{port}/health

# Stop
docker stop {app-name}
docker rm {app-name}
```

**Multi-service:**
```bash
# Start all services
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f

# Stop
docker-compose down
```

### Step 5: Production Deployment

Choose deployment method:

**A. Deploy to Remote Server (SSH)**
```bash
# 1. Build and tag
docker build -t registry.example.com/{app}:{version} .
docker push registry.example.com/{app}:{version}

# 2. SSH to server
ssh user@server

# 3. Pull and run
docker pull registry.example.com/{app}:{version}
docker-compose up -d
```

**B. Deploy with docker-compose**
```bash
# On server:
# 1. Pull latest code
git pull origin main

# 2. Rebuild and restart
docker-compose down
docker-compose up -d --build
```

**C. Blue-Green Deployment**
```bash
# 1. Start new version (green)
docker-compose -f docker-compose.green.yml up -d

# 2. Test green environment
curl http://localhost:8001/health

# 3. Switch traffic (update nginx/load balancer)
# ... update config ...

# 4. Stop old version (blue)
docker-compose -f docker-compose.blue.yml down
```

### Step 6: Post-Deployment Validation

```bash
# Check running containers
docker ps

# Check logs for errors
docker-compose logs --tail=100 -f

# Monitor resource usage
docker stats

# Health checks
curl http://localhost/health
curl http://localhost/api/health
```

### Step 7: Monitoring & Maintenance

```bash
# View logs
docker-compose logs -f {service}

# Execute commands in container
docker-compose exec {service} sh

# Restart service
docker-compose restart {service}

# View resource usage
docker stats
```

## Rollback Procedure

If deployment fails:

```bash
# 1. Stop current version
docker-compose down

# 2. Revert to previous version
git checkout {previous-commit}

# 3. Rebuild and redeploy
docker-compose up -d --build

# 4. Verify
docker-compose ps
docker-compose logs -f
```

## Cleanup

```bash
# Remove stopped containers
docker container prune -f

# Remove unused images
docker image prune -f

# Remove unused volumes (CAREFUL!)
docker volume prune -f

# Full cleanup
docker system prune -af
```

## Security Best Practices

1. **Scan images**:
   ```bash
   docker scan {image-name}
   ```

2. **Non-root user**: Ensure Dockerfile uses non-root user

3. **Secrets**: Use Docker secrets or env files (never commit)

4. **Update base images**: Regularly rebuild with latest base images

5. **Resource limits**: Set memory/CPU limits in docker-compose.yml

## Hermetic Principles

**Vibration** - Ship iteratively. Test locally first.
**Polarity** - Balance automation with manual oversight.
**Rhythm** - Maintain deployment cadence. Monitor continuously.

---

**Execute the deployment workflow above. Build, test, deploy. Validate thoroughly.**
