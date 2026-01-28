# Transcendence Documentation

Complete documentation for the ft_transcendence project.

---

## **📚 Documentation Index**

### **Getting Started**
- [Quick Start Guide](./QUICK_START.md) - Get up and running in 5 minutes
- [Full Setup Guide](./SETUP.md) - Detailed installation and configuration
- [Troubleshooting](./TROUBLESHOOTING.md) - Common issues and solutions

### **Architecture & Design**
- [Project Structure](../context/structure.md) - File organization and architecture
- [Project Plan](../context/2.%20project_plan.md) - Module selection and justification
- [Simplified Plan](../context/plan_simplification.md) - Faster implementation approach

### **Development Guides**
- Authentication Setup (Coming soon)
- RBAC Implementation (Coming soon)
- Database Schema (Coming soon)
- API Routes (Coming soon)
- UI Components (Coming soon)

### **Deployment**
- Docker Setup (See [SETUP.md](./SETUP.md))
- Production Build (Coming soon)
- CI/CD Pipeline (Coming soon)

---

## **🚀 Quick Links**

| Topic | Link | Description |
|:------|:-----|:------------|
| **Installation** | [SETUP.md](./SETUP.md) | Full setup instructions |
| **Quick Start** | [QUICK_START.md](./QUICK_START.md) | 5-minute setup |
| **Problems?** | [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) | Fix common issues |
| **Architecture** | [structure.md](../context/structure.md) | Project structure |
| **Modules** | [project_plan.md](../context/2.%20project_plan.md) | 17-point module plan |

---

## **📖 Learning Resources**

### **Next.js**
- [Next.js Documentation](https://nextjs.org/docs)
- [Next.js Learn](https://nextjs.org/learn) - Interactive tutorial
- [App Router Guide](https://nextjs.org/docs/app)

### **React**
- [React Documentation](https://react.dev)
- [React Hooks](https://react.dev/reference/react)
- [Server Components](https://react.dev/reference/react/use-server)

### **TypeScript**
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [TypeScript with React](https://react.dev/learn/typescript)

### **Prisma**
- [Prisma Documentation](https://www.prisma.io/docs)
- [Prisma Schema Reference](https://www.prisma.io/docs/reference/api-reference/prisma-schema-reference)
- [Prisma Client API](https://www.prisma.io/docs/reference/api-reference/prisma-client-reference)

### **Tailwind CSS**
- [Tailwind Documentation](https://tailwindcss.com/docs)
- [Tailwind UI Components](https://tailwindui.com/)
- [shadcn/ui](https://ui.shadcn.com/) - Component library

### **Authentication**
- [NextAuth.js](https://next-auth.js.org/)
- [Auth.js v5 Beta](https://authjs.dev/)

---

## **🛠️ Development Workflow**

### **Daily Development**

```bash
# 1. Start database
docker-compose up -d db

# 2. Start dev server
npm run dev

# 3. (Optional) Open database GUI
npx prisma studio

# 4. Code, test, repeat...

# 5. Before committing
npm run lint
npm run build

# 6. Commit and push
git add .
git commit -m "descriptive message"
git push
```

### **Working with Database**

```bash
# View database in GUI
npx prisma studio

# Update schema
# 1. Edit prisma/schema.prisma
# 2. Push changes
npx prisma db push

# Create migration (for production)
npx prisma migrate dev --name descriptive_name

# Reset database (WARNING: deletes all data)
npx prisma migrate reset
```

### **Adding UI Components**

```bash
# Install shadcn/ui component
npx shadcn-ui@latest add button
npx shadcn-ui@latest add card
npx shadcn-ui@latest add form

# Components are added to src/components/ui/
# Customize as needed
```

---

## **📝 Code Standards**

### **File Naming**
- **Components:** PascalCase (`Button.tsx`, `UserProfile.tsx`)
- **Utilities:** camelCase (`formatDate.ts`, `apiClient.ts`)
- **Pages:** lowercase (`page.tsx`, `layout.tsx`)
- **API Routes:** lowercase (`route.ts`)

### **TypeScript**
- Use TypeScript for all files
- Define interfaces for all props and data structures
- Avoid `any` type - use `unknown` if type is truly unknown
- Export types from dedicated `types/` directory

### **React Best Practices**
- Use Server Components by default
- Mark Client Components with `'use client'`
- Keep components small and focused
- Extract reusable logic to custom hooks
- Use proper TypeScript prop types

### **Git Commit Messages**
```
<type>: <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting, missing semicolons, etc.
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance

**Example:**
```
feat: add user profile page

- Create profile page component
- Add avatar upload functionality
- Implement profile update form

Closes #123
```

---

## **🔒 Security Best Practices**

1. **Never commit secrets**
   - Use `.env.local` for sensitive data
   - Keep `.env.example` updated with placeholders
   - Add `.env.local` to `.gitignore`

2. **Validate all inputs**
   - Use Zod schemas for validation
   - Validate on both frontend and backend
   - Sanitize user inputs

3. **Use environment variables**
   - Store API keys in environment variables
   - Use `NEXT_PUBLIC_` prefix only for client-side vars
   - Never expose database credentials

4. **Implement proper authentication**
   - Use NextAuth.js for authentication
   - Hash passwords with bcrypt
   - Implement RBAC for authorization
   - Use secure session management

---

## **🧪 Testing** (Coming Soon)

```bash
# Run tests
npm test

# Run tests in watch mode
npm test -- --watch

# Run E2E tests
npm run test:e2e

# Check coverage
npm run test:coverage
```

---

## **📦 Project Structure**

```
ft_transcendence/
├── src/
│   ├── app/                    # Next.js App Router
│   │   ├── (auth)/            # Auth pages
│   │   ├── (dashboard)/       # Protected pages
│   │   ├── (admin)/           # Admin pages
│   │   └── api/               # API routes
│   ├── components/            # React components
│   │   └── ui/                # Design system
│   ├── lib/                   # Business logic
│   │   ├── auth/              # Auth utilities
│   │   ├── db/                # Database utilities
│   │   ├── services/          # Business services
│   │   └── validations/       # Zod schemas
│   └── types/                 # TypeScript types
├── prisma/                    # Database schema
├── docs/                      # Documentation (you are here!)
├── context/                   # Project context & planning
└── docker-compose.yml         # Docker configuration
```

---

## **🤝 Contributing**

### **Before You Code**
1. Read the [Project Plan](../context/2.%20project_plan.md)
2. Check assigned tasks (GitHub Issues/Jira)
3. Create a feature branch: `git checkout -b feature/your-feature`

### **While Coding**
1. Follow code standards
2. Write descriptive commit messages
3. Test your changes
4. Update documentation if needed

### **Before Pushing**
1. Run linter: `npm run lint`
2. Test build: `npm run build`
3. Review your changes
4. Push and create Pull Request

### **Code Review**
- Request review from at least one team member
- Address review comments
- Merge after approval

---

## **🎯 Module Implementation Checklist**

Track your progress on the 17-point module plan:

### **Major Modules (2pts each)**
- [ ] Next.js Framework (Frontend + Backend)
- [ ] Standard User Management (profiles, avatars, friends)
- [ ] RBAC (Role-Based Access Control)
- [ ] Organization System (Multi-tenant)
- [ ] Advanced Analytics Dashboard

### **Minor Modules (1pt each)**
- [ ] Prisma ORM
- [ ] Custom Design System (10+ components)
- [ ] Advanced Search (filters, sorting, pagination)
- [ ] Server-Side Rendering (FREE with Next.js!)
- [ ] OAuth 2.0 (Google, GitHub, 42)
- [ ] 2FA (Two-Factor Authentication)
- [ ] Notification System

**Total: 17 points** ✅

---

## **📞 Support & Help**

### **Internal Resources**
- Team Discord channel
- Weekly sync meetings
- Pair programming sessions
- Code review sessions

### **External Resources**
- [Next.js Discord](https://nextjs.org/discord)
- [Prisma Discord](https://pris.ly/discord)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/next.js)
- [GitHub Discussions](https://github.com/vercel/next.js/discussions)

---

## **📋 Useful Commands Reference**

```bash
# Development
npm run dev              # Start dev server
npm run build            # Build for production
npm run start            # Start production server
npm run lint             # Run ESLint

# Database
npx prisma studio        # Open database GUI
npx prisma db push       # Push schema changes
npx prisma migrate dev   # Create migration
npx prisma generate      # Generate Prisma Client

# Docker
docker-compose up -d     # Start all services
docker-compose down      # Stop all services
docker-compose logs -f   # View logs
docker-compose restart   # Restart services

# Git
git status               # Check status
git add .                # Stage changes
git commit -m "msg"      # Commit
git push                 # Push to remote
git pull                 # Pull changes

# shadcn/ui
npx shadcn-ui@latest add button    # Add component
npx shadcn-ui@latest add form      # Add form
```

---

## **🎓 Learning Path for New Members**

1. **Week 1: Setup & Basics**
   - Complete [Quick Start](./QUICK_START.md)
   - Read [Next.js Tutorial](https://nextjs.org/learn)
   - Understand project structure

2. **Week 2: Core Concepts**
   - Learn React Server Components
   - Study Prisma ORM
   - Explore authentication flow

3. **Week 3: Contributing**
   - Pick up first task
   - Implement a component
   - Submit first PR

4. **Week 4+: Advanced**
   - Work on assigned modules
   - Review team members' code
   - Share knowledge

---

**Questions? Ask in the team Discord or check [Troubleshooting](./TROUBLESHOOTING.md)!**

---

*Last updated: January 28, 2026*  
*Maintained by the ft_transcendence team*
