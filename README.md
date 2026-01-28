# Transcendence - Marketing/Lead Generation Platform

> *This project has been created as part of the 42 curriculum.*

A full-stack web application built with Next.js, featuring multi-tenant organization management, advanced analytics, and comprehensive user management.

---

## **🚀 Quick Start**

```bash
# 1. Install Node.js (if not installed)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# 2. Initialize Next.js project
npx create-next-app@latest . --typescript --tailwind --app --eslint --src-dir --import-alias "@/*" --use-npm

# 3. Run automated setup
chmod +x setup.sh
./setup.sh

# 4. Start development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser! 🎉

**Detailed instructions:** See [`docs/QUICK_START.md`](./docs/QUICK_START.md)

---

## **📋 Project Overview**

### **What We're Building**

A B2B SaaS platform for marketing and lead generation with:
- 🏢 **Multi-tenant architecture** - Organizations with member management
- 👥 **Advanced user management** - Profiles, friends, 2FA, OAuth
- 📊 **Analytics dashboard** - Campaign metrics, charts, and exports
- 🔐 **Role-based access control** - Granular permissions system
- 🔔 **Real-time notifications** - Toast and persistent notification center
- 🔍 **Advanced search** - Filters, sorting, and pagination

### **Tech Stack**

| Category | Technology |
|:---------|:-----------|
| **Framework** | Next.js 14+ (App Router) |
| **Language** | TypeScript |
| **Frontend** | React, Tailwind CSS, shadcn/ui |
| **Backend** | Next.js API Routes |
| **Database** | PostgreSQL |
| **ORM** | Prisma |
| **Auth** | NextAuth.js (Auth.js v5) |
| **Validation** | Zod |
| **Deployment** | Docker & Docker Compose |

---

## **📚 Documentation**

| Document | Description |
|:---------|:------------|
| [**Quick Start**](./docs/QUICK_START.md) | Get running in 5 minutes |
| [**Full Setup**](./docs/SETUP.md) | Comprehensive installation guide |
| [**Troubleshooting**](./docs/TROUBLESHOOTING.md) | Fix common issues |
| [**Quick Reference**](./docs/QUICK_REFERENCE.md) | Command cheat sheet |
| [**Docs Index**](./docs/README.md) | Complete documentation hub |
| [**Next Steps**](./NEXT_STEPS.md) | What to do after setup |

---

## **🎯 Module Plan (17 Points)**

We've selected the following modules to exceed the required 14 points:

### **Major Modules (10 points)**
- ✅ **Next.js Framework** (2pts) - Full-stack React framework
- 🔨 **Standard User Management** (2pts) - Profiles, avatars, friends
- 🔨 **RBAC** (2pts) - Role-based access control
- 🔨 **Organization System** (2pts) - Multi-tenant architecture
- 🔨 **Analytics Dashboard** (2pts) - Charts, filters, exports

### **Minor Modules (7 points)**
- ✅ **Prisma ORM** (1pt) - Type-safe database access
- 🔨 **Design System** (1pt) - 10+ reusable components
- 🔨 **Advanced Search** (1pt) - Filters, sorting, pagination
- ✅ **SSR** (1pt) - Server-side rendering (built-in!)
- 🔨 **OAuth 2.0** (1pt) - Google, GitHub, 42 login
- 🔨 **2FA** (1pt) - Two-factor authentication
- 🔨 **Notifications** (1pt) - Toast + persistent center

**Total: 17 points** (3-point safety margin)

See [`context/2. project_plan.md`](./context/2.%20project_plan.md) for full details.

---

## **🏗️ Project Structure**

```
ft_transcendence/
├── src/
│   ├── app/              # Next.js App Router
│   │   ├── (auth)/      # Authentication pages
│   │   ├── (dashboard)/ # User dashboard
│   │   ├── (admin)/     # Admin panel
│   │   └── api/         # API routes
│   ├── components/      # React components
│   │   └── ui/          # Design system
│   ├── lib/             # Business logic
│   │   ├── auth/        # Auth utilities
│   │   ├── db/          # Database
│   │   ├── services/    # Business services
│   │   └── validations/ # Zod schemas
│   └── types/           # TypeScript types
├── prisma/              # Database schema
├── docs/                # Documentation
├── context/             # Project planning
└── docker-compose.yml   # Docker setup
```

See [`context/structure.md`](./context/structure.md) for detailed architecture.

---

## **👥 Team & Roles**

| Member | Role(s) | Responsibilities |
|:-------|:--------|:-----------------|
| TBD | Product Owner | Vision, features, backlog |
| TBD | Project Manager | Coordination, tracking |
| TBD | Tech Lead | Architecture, code quality |
| All | Developers | Implementation, reviews |

*Roles will be assigned and documented as team forms.*

---

## **🛠️ Development**

### **Prerequisites**
- Node.js 18+ ([Install](https://nodejs.org/))
- Docker & Docker Compose ([Install](https://docs.docker.com/get-docker/))
- Git ([Install](https://git-scm.com/))

### **Setup**
```bash
# Clone repository
git clone https://github.com/Dangerdrive/ft_transcendence.git
cd ft_transcendence

# Run automated setup
./setup.sh

# Start development
npm run dev
```

### **Common Commands**
```bash
npm run dev              # Start dev server
npm run build            # Build for production
npm run lint             # Run ESLint
npx prisma studio        # Open database GUI
docker-compose up -d     # Start Docker services
```

See [`docs/QUICK_REFERENCE.md`](./docs/QUICK_REFERENCE.md) for more commands.

---

## **🧪 Testing** (Coming Soon)

```bash
npm test                 # Run unit tests
npm run test:e2e         # Run E2E tests
npm run test:coverage    # Check coverage
```

---

## **🚢 Deployment** (Coming Soon)

```bash
# Build and run with Docker
docker-compose up -d --build

# Access at http://localhost:3000
```

---

## **📖 Learning Resources**

### **Official Documentation**
- [Next.js](https://nextjs.org/docs)
- [React](https://react.dev)
- [TypeScript](https://typescriptlang.org/docs/)
- [Prisma](https://prisma.io/docs)
- [NextAuth.js](https://next-auth.js.org/)
- [Tailwind CSS](https://tailwindcss.com/docs)

### **Project Documentation**
- [Setup Guide](./docs/SETUP.md)
- [Project Plan](./context/2.%20project_plan.md)
- [Troubleshooting](./docs/TROUBLESHOOTING.md)

---

## **🤝 Contributing**

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Make your changes
3. Run tests and linter
4. Commit: `git commit -m "feat: descriptive message"`
5. Push: `git push origin feature/your-feature`
6. Create Pull Request
7. Wait for code review
8. Merge after approval

See [`docs/README.md`](./docs/README.md) for detailed guidelines.

---

## **📝 Git Workflow**

```bash
# Start new feature
git checkout main
git pull
git checkout -b feature/your-feature

# Work and commit
git add .
git commit -m "feat: your feature"

# Push and create PR
git push -u origin feature/your-feature
```

---

## **🐛 Issues & Support**

- **Documentation:** Check [`docs/TROUBLESHOOTING.md`](./docs/TROUBLESHOOTING.md)
- **Team:** Ask in Discord
- **Bugs:** Create GitHub issue
- **Questions:** Check [docs/README.md](./docs/README.md) first

---

## **📄 License**

This is a student project for educational purposes as part of the 42 curriculum.

---

## **🙏 Acknowledgments**

- 42 School for the project specification
- Next.js team for the amazing framework
- Vercel for hosting and resources
- Prisma for the excellent ORM
- shadcn for the UI components

---

## **📊 Project Status**

- [x] Project planning complete
- [x] Documentation complete
- [x] Tech stack selected
- [ ] Next.js project initialized
- [ ] Database schema implemented
- [ ] Authentication setup
- [ ] RBAC implementation
- [ ] UI components built
- [ ] Core features developed
- [ ] Testing implemented
- [ ] Production deployment

---

## **🔗 Quick Links**

- 📚 [Full Documentation](./docs/README.md)
- 🚀 [Quick Start Guide](./docs/QUICK_START.md)
- 📋 [Quick Reference](./docs/QUICK_REFERENCE.md)
- 📝 [Project Plan](./context/2.%20project_plan.md)
- 🎯 [Next Steps](./NEXT_STEPS.md)

---

**Ready to start? Follow the [Quick Start Guide](./docs/QUICK_START.md)!**

*Last updated: January 28, 2026*

