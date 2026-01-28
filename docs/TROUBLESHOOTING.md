# Troubleshooting Guide

Common issues and their solutions for the Transcendence project.

---

## **Installation Issues**

### **Node.js or npm not found**

**Problem:** `Command 'node' not found` or `Command 'npm' not found`

**Solution:**

```bash
# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify installation
node --version
npm --version
```

### **Permission denied when installing packages**

**Problem:** `EACCES: permission denied`

**Solution:**

```bash
# Don't use sudo with npm!
# Instead, configure npm to use a different directory

mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Now install packages without sudo
npm install -g npm@latest
```

---

## **Database Issues**

### **Cannot connect to PostgreSQL**

**Problem:** `Error: P1001: Can't reach database server`

**Solutions:**

1. **Check if PostgreSQL is running:**
```bash
docker ps
# Should show transcendence-db container
```

2. **Start the database:**
```bash
docker-compose up -d db
```

3. **Check DATABASE_URL:**
```bash
# In .env.local, make sure it matches:
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/transcendence?schema=public"
```

4. **Check Docker logs:**
```bash
docker-compose logs db
```

### **Port 5432 already in use**

**Problem:** PostgreSQL port conflict

**Solution:**

```bash
# Find what's using port 5432
sudo lsof -i :5432

# If it's another PostgreSQL instance, stop it
sudo systemctl stop postgresql

# Or change the port in docker-compose.yml
ports:
  - "5433:5432"  # Use 5433 on host instead

# Update DATABASE_URL accordingly
DATABASE_URL="postgresql://postgres:postgres@localhost:5433/transcendence?schema=public"
```

### **Prisma Client not generated**

**Problem:** `Cannot find module '@prisma/client'`

**Solution:**

```bash
# Generate Prisma Client
npx prisma generate

# If using VS Code, restart TypeScript server
# Cmd/Ctrl + Shift + P -> "TypeScript: Restart TS Server"
```

### **Database migration failed**

**Problem:** Migration errors or schema mismatch

**Solution:**

```bash
# Reset database (WARNING: This deletes all data!)
npx prisma migrate reset

# Or manually drop and recreate
docker-compose down -v
docker-compose up -d db
npx prisma db push
```

---

## **Next.js Issues**

### **Port 3000 already in use**

**Problem:** `Port 3000 is already in use`

**Solution:**

```bash
# Option 1: Kill the process
lsof -ti:3000 | xargs kill -9

# Option 2: Use a different port
npm run dev -- -p 3001

# Option 3: Find and stop the process manually
lsof -i :3000
kill -9 <PID>
```

### **Module not found errors**

**Problem:** `Error: Cannot find module 'xyz'`

**Solution:**

```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json .next
npm install

# If still not working, clear npm cache
npm cache clean --force
npm install
```

### **TypeScript errors after installing packages**

**Problem:** TypeScript not recognizing new types

**Solution:**

```bash
# Restart TypeScript server in VS Code
# Cmd/Ctrl + Shift + P -> "TypeScript: Restart TS Server"

# Or restart your editor
```

### **Hot reload not working**

**Problem:** Changes not reflecting in browser

**Solution:**

```bash
# 1. Check if file watcher limit is reached (Linux)
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# 2. Restart dev server
# Ctrl+C to stop, then:
npm run dev

# 3. Clear .next cache
rm -rf .next
npm run dev
```

---

## **Docker Issues**

### **Docker daemon not running**

**Problem:** `Cannot connect to the Docker daemon`

**Solution:**

```bash
# Start Docker service
sudo systemctl start docker

# Enable Docker to start on boot
sudo systemctl enable docker

# Check status
sudo systemctl status docker
```

### **Permission denied (Docker)**

**Problem:** `permission denied while trying to connect to the Docker daemon`

**Solution:**

```bash
# Add your user to docker group
sudo usermod -aG docker $USER

# Log out and log back in, or run:
newgrp docker

# Verify
docker ps
```

### **Container keeps restarting**

**Problem:** Container starts then immediately stops

**Solution:**

```bash
# Check container logs
docker-compose logs app
docker-compose logs db

# Check container status
docker-compose ps

# Restart specific service
docker-compose restart app
```

---

## **Build Issues**

### **Build fails with TypeScript errors**

**Problem:** `npm run build` fails with type errors

**Solution:**

```bash
# Check for errors
npm run lint

# Fix common issues
# 1. Update TypeScript
npm install --save-dev typescript@latest

# 2. Clear build cache
rm -rf .next

# 3. Regenerate Prisma Client
npx prisma generate

# 4. Try building again
npm run build
```

### **Out of memory during build**

**Problem:** `JavaScript heap out of memory`

**Solution:**

```bash
# Increase Node.js memory limit
export NODE_OPTIONS="--max-old-space-size=4096"

# Add to package.json build script
"build": "NODE_OPTIONS='--max-old-space-size=4096' next build"

# Or build with Docker (recommended for production)
docker-compose build app
```

---

## **Environment Variable Issues**

### **Environment variables not loading**

**Problem:** `process.env.VARIABLE_NAME` is undefined

**Solution:**

```bash
# 1. Make sure .env.local exists
cp .env.example .env.local

# 2. Restart dev server (required for env changes)
# Ctrl+C
npm run dev

# 3. For client-side variables, use NEXT_PUBLIC_ prefix
NEXT_PUBLIC_API_URL=http://localhost:3000

# 4. Check Next.js env docs
# https://nextjs.org/docs/app/building-your-application/configuring/environment-variables
```

### **NEXTAUTH_SECRET missing**

**Problem:** NextAuth.js errors about missing secret

**Solution:**

```bash
# Generate a secret
openssl rand -base64 32

# Add to .env.local
NEXTAUTH_SECRET="your-generated-secret-here"
NEXTAUTH_URL="http://localhost:3000"

# Restart dev server
npm run dev
```

---

## **Git Issues**

### **Large files or node_modules committed**

**Problem:** Accidentally committed node_modules or .env files

**Solution:**

```bash
# Remove from Git but keep locally
git rm -r --cached node_modules
git rm --cached .env.local

# Make sure .gitignore is correct
echo "node_modules/" >> .gitignore
echo ".env.local" >> .gitignore
echo ".next/" >> .gitignore

# Commit the changes
git add .gitignore
git commit -m "Remove ignored files from Git"
git push
```

### **Merge conflicts**

**Problem:** Git merge conflicts

**Solution:**

```bash
# See conflicted files
git status

# For each conflicted file, edit and resolve conflicts
# Look for <<<<<<< HEAD markers

# After resolving
git add <file>
git commit -m "Resolve merge conflicts"

# Or abort merge
git merge --abort
```

---

## **Performance Issues**

### **Slow development server**

**Problem:** Dev server is slow or laggy

**Solution:**

```bash
# 1. Disable experimental features in next.config.js
# 2. Reduce file watchers (Linux)
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# 3. Clear cache
rm -rf .next node_modules/.cache

# 4. Use SWC instead of Babel (default in Next.js 14+)
```

### **Large bundle size**

**Problem:** Application bundle is too large

**Solution:**

```bash
# Analyze bundle
npm install --save-dev @next/bundle-analyzer

# Add to next.config.js
const withBundleAnalyzer = require('@next/bundle-analyzer')({
  enabled: process.env.ANALYZE === 'true',
})

module.exports = withBundleAnalyzer({
  // your config
})

# Run analysis
ANALYZE=true npm run build

# Optimize by:
# 1. Using dynamic imports
# 2. Removing unused dependencies
# 3. Using next/image for images
# 4. Code splitting
```

---

## **Authentication Issues**

### **OAuth callback errors**

**Problem:** OAuth redirect fails or shows errors

**Solution:**

```bash
# 1. Check callback URLs in provider settings
# Google: http://localhost:3000/api/auth/callback/google
# GitHub: http://localhost:3000/api/auth/callback/github

# 2. Verify .env.local has correct client IDs and secrets
# 3. Make sure NEXTAUTH_URL matches your domain
NEXTAUTH_URL="http://localhost:3000"

# 4. Check provider is enabled in NextAuth config
```

### **Session not persisting**

**Problem:** User gets logged out on refresh

**Solution:**

```bash
# 1. Check NEXTAUTH_SECRET is set
# 2. For database sessions, make sure Prisma adapter is configured
# 3. Check Session model exists in Prisma schema
# 4. Clear cookies and try again
```

---

## **Getting More Help**

If your issue isn't listed here:

1. **Check the logs:**
   ```bash
   # Next.js logs
   npm run dev
   
   # Docker logs
   docker-compose logs -f
   
   # Prisma logs
   DEBUG="prisma:*" npm run dev
   ```

2. **Search documentation:**
   - [Next.js Docs](https://nextjs.org/docs)
   - [Prisma Docs](https://www.prisma.io/docs)
   - [Docker Docs](https://docs.docker.com/)

3. **Ask the team:**
   - Post in Discord channel
   - Create a GitHub issue
   - Ask during team meetings

4. **Clean slate (last resort):**
   ```bash
   # Complete reset
   docker-compose down -v
   rm -rf node_modules .next package-lock.json
   npm install
   docker-compose up -d db
   npx prisma db push
   npm run dev
   ```

---

**Still stuck? Don't hesitate to ask for help!** 🤝
