# 📋 Quick Reference Card - Transcendence

## **Essential Commands**

### **Development**
```bash
npm run dev              # Start dev server (http://localhost:3000)
npm run build            # Build for production
npm run lint             # Run ESLint
npm run start            # Start production server
```

### **Database**
```bash
npx prisma studio        # Open database GUI (http://localhost:5555)
npx prisma db push       # Push schema changes (fast, dev only)
npx prisma migrate dev   # Create migration (production-safe)
npx prisma generate      # Generate Prisma Client
```

### **Docker**
```bash
docker-compose up -d     # Start all services
docker-compose up -d db  # Start only database
docker-compose down      # Stop all services
docker-compose logs -f   # View logs
docker-compose restart   # Restart services
```

### **Git**
```bash
git status               # Check status
git add .                # Stage all changes
git commit -m "message"  # Commit with message
git push                 # Push to remote
git pull                 # Pull from remote
```

---

## **File Locations**

| What | Where |
|:-----|:------|
| Pages | `src/app/**/page.tsx` |
| API Routes | `src/app/api/**/route.ts` |
| Components | `src/components/**/*.tsx` |
| UI Components | `src/components/ui/**/*.tsx` |
| Services | `src/lib/services/**/*.ts` |
| Database | `prisma/schema.prisma` |
| Env Variables | `.env.local` |
| Config | `next.config.js` |

---

## **Common Patterns**

### **Server Component (Default)**
```typescript
// Fetch data directly in component
export default async function Page() {
  const data = await prisma.user.findMany()
  return <div>{/* render */}</div>
}
```

### **Client Component**
```typescript
'use client'
import { useState } from 'react'

export default function Component() {
  const [state, setState] = useState()
  return <div>{/* interactive */}</div>
}
```

### **API Route**
```typescript
// src/app/api/users/route.ts
import { NextResponse } from 'next/server'

export async function GET() {
  const users = await prisma.user.findMany()
  return NextResponse.json(users)
}
```

### **Server Action**
```typescript
'use server'

export async function createUser(data: FormData) {
  const user = await prisma.user.create({
    data: { /* ... */ }
  })
  revalidatePath('/users')
}
```

---

## **Environment Variables**

```env
# Required
DATABASE_URL="postgresql://user:pass@localhost:5432/db"
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="generate-with-openssl-rand-base64-32"

# Optional OAuth
GOOGLE_CLIENT_ID="..."
GOOGLE_CLIENT_SECRET="..."
GITHUB_CLIENT_ID="..."
GITHUB_CLIENT_SECRET="..."
```

---

## **Troubleshooting**

| Problem | Solution |
|:--------|:---------|
| Port 3000 in use | `lsof -ti:3000 \| xargs kill -9` |
| DB connection failed | `docker-compose restart db` |
| Module not found | `rm -rf node_modules && npm i` |
| Prisma Client error | `npx prisma generate` |
| Hot reload not working | `rm -rf .next && npm run dev` |

---

## **Module Checklist (17pts)**

### Major (2pts each)
- [ ] Next.js Framework
- [ ] User Management (profiles, friends)
- [ ] RBAC
- [ ] Organizations (multi-tenant)
- [ ] Analytics Dashboard

### Minor (1pt each)
- [ ] Prisma ORM
- [ ] Design System (10+ components)
- [ ] Advanced Search
- [ ] SSR (free!)
- [ ] OAuth 2.0
- [ ] 2FA
- [ ] Notifications

---

## **Quick Links**

- 📖 [Full Setup](./SETUP.md)
- 🚀 [Quick Start](./QUICK_START.md)
- 🔧 [Troubleshooting](./TROUBLESHOOTING.md)
- 📚 [Docs Index](./README.md)

---

## **Team Workflow**

```mermaid
graph LR
    A[Pull latest] --> B[Create branch]
    B --> C[Code & test]
    C --> D[Lint & build]
    D --> E[Commit & push]
    E --> F[Create PR]
    F --> G[Code review]
    G --> H[Merge]
```

---

**Print this card and keep it handy!** 📌
