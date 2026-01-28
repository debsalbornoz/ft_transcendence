# Quick Start Guide

Get the Transcendence project up and running in **5 minutes**!

---

## **TL;DR - Fastest Setup**

```bash
# 1. Install Node.js (if not installed)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# 2. Clone and setup
git clone https://github.com/Dangerdrive/ft_transcendence.git
cd ft_transcendence

# 3. Install dependencies
npm install

# 4. Set up environment
cp .env.example .env.local
# Edit .env.local with your database URL

# 5. Start database
docker-compose up -d db

# 6. Initialize database
npx prisma db push

# 7. Run development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) 🚀

---

## **Prerequisites Checklist**

Before you begin, make sure you have:

- [ ] **Node.js v18+** installed (`node --version`)
- [ ] **npm** installed (`npm --version`)
- [ ] **Docker** installed (`docker --version`)
- [ ] **Docker Compose** installed (`docker-compose --version`)
- [ ] **Git** installed (`git --version`)

---

## **Step-by-Step Setup**

### **1. Install Node.js (if needed)**

**Ubuntu/Debian:**
```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

**macOS:**
```bash
brew install node
```

**Windows:**
Download from [nodejs.org](https://nodejs.org/)

### **2. Clone Repository**

```bash
git clone https://github.com/Dangerdrive/ft_transcendence.git
cd ft_transcendence
```

### **3. Install Dependencies**

```bash
npm install
```

This will install:
- Next.js
- React
- TypeScript
- Prisma
- Tailwind CSS
- And all other dependencies

### **4. Configure Environment**

```bash
# Copy environment template
cp .env.example .env.local

# Generate secret for NextAuth
openssl rand -base64 32
```

Edit `.env.local` and add:

```env
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/transcendence?schema=public"
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="your-generated-secret-here"
```

### **5. Start Database**

```bash
# Start PostgreSQL in Docker
docker-compose up -d db

# Verify it's running
docker ps
```

### **6. Initialize Database**

```bash
# Push Prisma schema to database
npx prisma db push

# (Optional) Open Prisma Studio to view database
npx prisma studio
```

### **7. Run Development Server**

```bash
npm run dev
```

The app will be available at **http://localhost:3000**

---

## **Verify Everything Works**

Check these URLs:

- ✅ **App:** http://localhost:3000
- ✅ **Prisma Studio:** http://localhost:5555 (run `npx prisma studio`)
- ✅ **API Health:** http://localhost:3000/api/health (after creating the endpoint)

---

## **Common First-Time Issues**

### **Port 3000 is already in use**

```bash
# Kill the process
lsof -ti:3000 | xargs kill -9

# Or use different port
npm run dev -- -p 3001
```

### **Database connection error**

```bash
# Make sure Docker is running
docker ps

# Restart database
docker-compose restart db

# Check DATABASE_URL in .env.local
```

### **"Cannot find module" errors**

```bash
# Delete node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

---

## **Next Steps**

After successful setup:

1. 📖 Read the full [Setup Guide](./SETUP.md)
2. 🏗️ Check the [Project Structure](./STRUCTURE.md)
3. 🔐 Set up [Authentication](./AUTHENTICATION.md)
4. 🎨 Build your first component
5. 🚀 Start coding!

---

## **Development Workflow**

```bash
# Daily workflow
docker-compose up -d db    # Start database
npm run dev                # Start dev server
# ... code code code ...
npm run lint               # Check for errors
git add .                  # Stage changes
git commit -m "message"    # Commit
git push                   # Push to GitHub
```

---

## **Useful Commands**

| Command | Description |
|:--------|:------------|
| `npm run dev` | Start development server |
| `npm run build` | Build for production |
| `npm run lint` | Run ESLint |
| `npx prisma studio` | Open database GUI |
| `npx prisma db push` | Update database schema |
| `docker-compose up -d` | Start all services |
| `docker-compose logs -f` | View container logs |

---

## **Need Help?**

- 📚 [Full Setup Documentation](./SETUP.md)
- 🐛 [Troubleshooting Guide](./TROUBLESHOOTING.md)
- 💬 Ask in the team Discord channel
- 📖 [Next.js Docs](https://nextjs.org/docs)

---

**Happy coding! 🎉**
