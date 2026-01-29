# Quick Reference: Common Commands

## 🚀 Development

```bash
# Start development server
cd /home/fde-alen/Projetos/ft_transcendence/project
export DATABASE_URL="postgresql://postgres:postgres@localhost:5432/transcendence"
export NEXTAUTH_SECRET=$(openssl rand -base64 32)
npm run dev

# Server runs on http://localhost:3000
```

## 🗄️ Database

```bash
# Open Prisma Studio (GUI for database)
npm run db:studio

# Create migration after schema changes
npx prisma migrate dev --name <description>

# Push schema to database (dev only)
npx prisma db push

# Generate Prisma Client (after schema changes)
npx prisma generate

# View database URL
echo $DATABASE_URL
```

## 📝 Schema Management

```bash
# View Prisma schema
cat prisma/schema.prisma

# Format schema
npx prisma format

# Validate schema
npx prisma validate
```

## 🔨 Build & Deploy

```bash
# Build for production
npm run build

# Start production server
npm run start

# Run linter
npm run lint
```

## 📦 Dependencies

```bash
# List installed packages
npm ls

# Install new package
npm install <package>

# Install dev dependency
npm install -D <package>

# Update Prisma
npm update prisma @prisma/client
```

## 🐛 Debugging

```bash
# Enable Prisma debug logs
DEBUG=prisma:* npm run dev

# Check Node version
node --version

# Check npm version
npm --version

# Check PostgreSQL status
sudo systemctl status postgresql

# Connect to PostgreSQL
psql -U postgres -h localhost -d transcendence
```

## 🔄 Reset Database

```bash
# WARNING: Deletes all data
npx prisma migrate reset

# Then reseed:
npx prisma db seed
```

## 📋 TypeScript

```bash
# Type check without building
npx tsc --noEmit

# Check types
npx tsc --diagnostics
```

## 🎯 Project Structure Navigation

```bash
# Go to project root
cd /home/fde-alen/Projetos/ft_transcendence/project

# View project structure
tree -L 2 -I 'node_modules'

# Source code
ls src/

# Database schema
cat prisma/schema.prisma

# Configuration
ls -la | grep -E "(\\.env|next\\.config|tsconfig)"
```

## 📚 Documentation Files

```bash
# Project setup guide
cat SETUP_COMPLETE.md

# Full setup status
cat /home/fde-alen/Projetos/ft_transcendence/context/00_PROJECT_SETUP_COMPLETE.md

# Phase 1 implementation
cat /home/fde-alen/Projetos/ft_transcendence/context/PHASE_1_READY.md

# Architecture overview
cat /home/fde-alen/Projetos/ft_transcendence/context/3. ARCHITECTURE_ANALYSIS.md

# All documentation index
cat /home/fde-alen/Projetos/ft_transcendence/context/0. DOCUMENTATION_INDEX.md
```

## ⚡ Aliases (Optional)

Add to your `.bashrc` or `.zshrc`:

```bash
# Project navigation
alias ftproj="cd /home/fde-alen/Projetos/ft_transcendence/project"
alias ftdocs="cd /home/fde-alen/Projetos/ft_transcendence/context"

# Common commands
alias ftdev="ftproj && npm run dev"
alias ftbuild="ftproj && npm run build"
alias ftstudio="ftproj && npm run db:studio"
alias ftmigrate="ftproj && npx prisma migrate dev"
```

Then use:
```bash
ftdev          # Start development
ftstudio       # Open database GUI
ftmigrate      # Run migrations
```

## 🔐 Security Reminders

1. **Never commit** `.env.local` to git
2. **Generate new** `NEXTAUTH_SECRET` for production
3. **Change default** PostgreSQL password in production
4. **Use strong** database passwords
5. **Enable** HTTPS for production
6. **Rotate** OAuth tokens regularly

## 📍 Key Paths

| Path | Purpose |
|------|---------|
| `/home/fde-alen/Projetos/ft_transcendence/project` | Main project root |
| `/home/fde-alen/Projetos/ft_transcendence/context` | Documentation folder |
| `./src` | Application source code |
| `./prisma` | Database schema & migrations |
| `./.env.local` | Local environment variables |
| `./node_modules` | Dependencies (don't edit) |

## 🆘 Getting Help

1. Check `00_PROJECT_SETUP_COMPLETE.md` for overview
2. Review `PHASE_1_READY.md` for implementation help
3. See `3. ARCHITECTURE_ANALYSIS.md` for design questions
4. Check `6. KEY_DECISIONS_AND_JUSTIFICATIONS.md` for decision rationale
