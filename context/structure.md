## Project Structure - Next.js Full-Stack Application

### **Tech Stack:**
- **Framework:** Next.js 14+ with App Router (Frontend + Backend)
- **Language:** TypeScript
- **Database:** PostgreSQL
- **ORM:** Prisma
- **Auth:** NextAuth.js (Auth.js v5)
- **Styling:** Tailwind CSS + shadcn/ui
- **Validation:** Zod

---

### **Root Structure:**

```
transcendence/
┣ src/
┃ ┣ app/                          # Next.js App Router (Pages + API Routes)
┃ ┃ ┣ (auth)/                     # Auth route group
┃ ┃ ┃ ┣ login/
┃ ┃ ┃ ┗ register/
┃ ┃ ┣ (dashboard)/                # Protected route group
┃ ┃ ┃ ┣ dashboard/
┃ ┃ ┃ ┣ profile/
┃ ┃ ┃ ┣ friends/
┃ ┃ ┃ ┗ settings/
┃ ┃ ┣ (admin)/                    # Admin route group (RBAC protected)
┃ ┃ ┃ ┣ organizations/
┃ ┃ ┃ ┣ campaigns/
┃ ┃ ┃ ┣ analytics/
┃ ┃ ┃ ┗ users/
┃ ┃ ┣ api/                        # API Routes (Backend)
┃ ┃ ┃ ┣ auth/                     # NextAuth.js routes
┃ ┃ ┃ ┣ organizations/
┃ ┃ ┃ ┣ campaigns/
┃ ┃ ┃ ┣ leads/
┃ ┃ ┃ ┣ analytics/
┃ ┃ ┃ ┣ notifications/
┃ ┃ ┃ ┣ users/
┃ ┃ ┃ ┗ health/
┃ ┃ ┣ layout.tsx                  # Root layout
┃ ┃ ┣ page.tsx                    # Landing page (SSR)
┃ ┃ ┣ privacy/page.tsx
┃ ┃ ┗ terms/page.tsx
┃ ┃
┃ ┣ components/                   # Reusable UI Components
┃ ┃ ┣ ui/                         # Design System (shadcn/ui)
┃ ┃ ┃ ┣ button.tsx
┃ ┃ ┃ ┣ input.tsx
┃ ┃ ┃ ┣ select.tsx
┃ ┃ ┃ ┣ modal.tsx
┃ ┃ ┃ ┣ table.tsx
┃ ┃ ┃ ┣ badge.tsx
┃ ┃ ┃ ┣ card.tsx
┃ ┃ ┃ ┣ toast.tsx
┃ ┃ ┃ ┣ pagination.tsx
┃ ┃ ┃ ┗ loader.tsx
┃ ┃ ┣ forms/                      # Form components
┃ ┃ ┣ charts/                     # Analytics chart components
┃ ┃ ┣ layout/                     # Layout components (Header, Sidebar, etc.)
┃ ┃ ┗ shared/                     # Shared components
┃ ┃
┃ ┣ lib/                          # Business Logic & Utilities
┃ ┃ ┣ auth/                       # Auth utilities & config
┃ ┃ ┃ ┣ auth.config.ts            # NextAuth.js config
┃ ┃ ┃ ┣ auth-options.ts
┃ ┃ ┃ ┗ permissions.ts            # RBAC logic
┃ ┃ ┣ db/                         # Database
┃ ┃ ┃ ┣ prisma.ts                 # Prisma client
┃ ┃ ┃ ┗ seed.ts                   # Database seeding
┃ ┃ ┣ services/                   # Business logic layer
┃ ┃ ┃ ┣ organizations.service.ts
┃ ┃ ┃ ┣ campaigns.service.ts
┃ ┃ ┃ ┣ leads.service.ts
┃ ┃ ┃ ┣ analytics.service.ts
┃ ┃ ┃ ┣ notifications.service.ts
┃ ┃ ┃ ┗ users.service.ts
┃ ┃ ┣ validations/                # Zod schemas
┃ ┃ ┃ ┣ auth.schema.ts
┃ ┃ ┃ ┣ organization.schema.ts
┃ ┃ ┃ ┣ campaign.schema.ts
┃ ┃ ┃ ┗ user.schema.ts
┃ ┃ ┣ utils/                      # Utility functions
┃ ┃ ┃ ┣ date.ts
┃ ┃ ┃ ┣ format.ts
┃ ┃ ┃ ┗ export.ts
┃ ┃ ┗ constants/                  # Constants & enums
┃ ┃
┃ ┣ middleware.ts                 # Next.js middleware (Auth, RBAC)
┃ ┗ types/                        # TypeScript types & interfaces
┃
┣ prisma/
┃ ┣ schema.prisma                 # Prisma schema
┃ ┣ migrations/                   # Database migrations
┃ ┗ seed.ts                       # Seed script
┃
┣ public/                         # Static assets
┃ ┣ images/
┃ ┗ icons/
┃
┣ docker-compose.yml              # Docker setup
┣ Dockerfile                      # Next.js container
┣ .env.example                    # Environment variables template
┣ .env                            # Environment variables (gitignored)
┣ next.config.js                  # Next.js configuration
┣ tailwind.config.ts              # Tailwind CSS config
┣ tsconfig.json                   # TypeScript config
┗ README.md                       # Project documentation
```

---

### **API Route Structure (Backend Logic):**

Each API route follows this pattern:

```
src/app/api/[resource]/
┣ route.ts                        # GET, POST handlers
┣ [id]/
┃ ┗ route.ts                      # GET, PUT, PATCH, DELETE handlers
┗ [special-action]/
  ┗ route.ts                      # Special endpoints
```

**Example: Organizations API**
```
src/app/api/organizations/
┣ route.ts                        # GET (list), POST (create)
┣ [id]/
┃ ┗ route.ts                      # GET, PUT, DELETE
┣ [id]/members/
┃ ┗ route.ts                      # Organization members management
┗ [id]/stats/
  ┗ route.ts                      # Organization statistics
```

---

### **Service Layer Pattern:**

Services in `src/lib/services/` contain business logic and interact with Prisma:

```typescript
// src/lib/services/organizations.service.ts
import { prisma } from '@/lib/db/prisma';

export class OrganizationService {
  async create(data: CreateOrgData, userId: string) {
    // Business logic + Prisma queries
  }

  async findByUser(userId: string) {
    // Data isolation by organization
  }

  async addMember(orgId: string, userId: string, role: Role) {
    // RBAC logic
  }
}
```

---

### **Module Mapping:**

| Feature | Location | Description |
|:--------|:---------|:------------|
| **Authentication** | `src/lib/auth/`, `src/app/api/auth/` | NextAuth.js + OAuth + 2FA |
| **User Management** | `src/app/(dashboard)/profile/`, `src/lib/services/users.service.ts` | Profiles, avatars, friends, settings |
| **RBAC** | `src/lib/auth/permissions.ts`, `src/middleware.ts` | Role-based access control |
| **Organizations** | `src/app/(admin)/organizations/`, `src/app/api/organizations/` | Multi-tenant system |
| **Campaigns** | `src/app/(admin)/campaigns/`, `src/app/api/campaigns/` | Campaign management |
| **Analytics** | `src/app/(admin)/analytics/`, `src/app/api/analytics/` | Dashboard with charts & exports |
| **Design System** | `src/components/ui/` | 10+ reusable components |
| **Advanced Search** | Throughout admin pages with `searchParams` | Filters, sorting, pagination |
| **Notifications** | `src/lib/services/notifications.service.ts`, `src/components/notifications/` | Toast + persistent center |
| **SSR** | All pages by default with App Router | Server-side rendering (FREE!) |

---

### **Key Patterns:**

1. **Server Components (Default):** Fetch data directly in components
2. **Client Components:** Use `'use client'` for interactivity
3. **Server Actions:** For mutations (forms, etc.)
4. **API Routes:** For external API consumption or complex logic
5. **Middleware:** Auth checks, RBAC, redirects
6. **Prisma Client:** Single instance via `src/lib/db/prisma.ts`
7. **Zod Validation:** Frontend + Backend validation with same schemas

---

### **Database Models (Prisma):**

```prisma
// Core entities
- User (id, email, password, name, avatar, role, twoFactorSecret)
- Organization (id, name, plan, settings)
- UserOrganization (userId, organizationId, role)
- Campaign (id, organizationId, name, status, metrics)
- Lead (id, campaignId, email, status, source)
- Event (id, leadId, type, timestamp, metadata)
- Notification (id, userId, type, content, read, createdAt)
- Friend (userId, friendId, status, createdAt)
```

---

### **Development Workflow:**

1. **Define Prisma Schema** → Run migrations
2. **Create Zod Schemas** for validation
3. **Build Service Layer** with business logic
4. **Create API Routes** using services
5. **Build UI Components** (Server + Client)
6. **Add Pages** using components + API
7. **Test & Iterate**

---

### **Points Summary (17 points):**

✅ Next.js Framework (Major 2pts)
✅ RBAC (Major 2pts)
✅ Organization System (Major 2pts)
✅ Standard User Management (Major 2pts)
✅ Analytics Dashboard (Major 2pts)
✅ Prisma ORM (Minor 1pt)
✅ Design System (Minor 1pt)
✅ Advanced Search (Minor 1pt)
✅ SSR - FREE with Next.js! (Minor 1pt)
✅ OAuth 2.0 (Minor 1pt)
✅ 2FA (Minor 1pt)
✅ Notification System (Minor 1pt)
