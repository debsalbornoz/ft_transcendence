# Phase 1: Organizations & Access Control

## 🎯 Objective
Implement the tenant isolation layer and foundational access control system for the multi-tenant SaaS platform.

## ✅ Readiness Checklist
- ✅ Prisma Client configured and working
- ✅ PostgreSQL database ready
- ✅ Environment variables configured
- ✅ Next.js project builds successfully
- ✅ TypeScript configuration validated

## 📐 Database Schema (Phase 1 Models)

### 1. Organization (Root Entity)
Multi-tenant isolation - each customer is an organization.

```prisma
model Organization {
  id            String   @id @default(cuid())
  name          String
  slug          String   @unique
  description   String?
  logo          String?
  website       String?
  industry      String?  // e.g., "Healthcare", "Finance"

  // Settings
  settings      Json     @default("{}")  // Flexible settings JSON

  // Billing & Status
  plan          String   @default("free")  // free, pro, enterprise
  status        String   @default("active")  // active, suspended, deleted

  // Timestamps
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  deletedAt     DateTime?  // Soft delete for GDPR

  // Relations
  users         User[]
  memberships   Membership[]
  roles         Role[]
  permissions   Permission[]

  // Indexes for tenant queries
  @@index([slug])
  @@index([status])
}
```

### 2. User (Auth Entity)
User accounts - can belong to multiple organizations.

```prisma
model User {
  id            String   @id @default(cuid())
  email         String   @unique
  emailVerified DateTime?
  name          String?
  password      String?   // Hashed for local auth
  avatar        String?

  // Auth
  accounts      Account[]
  sessions      Session[]

  // Relationships
  memberships   Membership[]
  auditLogs     AuditLog[]

  // Timestamps
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  deletedAt     DateTime?

  @@index([email])
}
```

### 3. Account (OAuth)
NextAuth account linking for OAuth providers.

```prisma
model Account {
  id                 String  @id @default(cuid())
  userId             String
  type               String
  provider           String
  providerAccountId  String

  refresh_token      String?
  access_token       String?
  expires_at         Int?
  token_type         String?
  scope              String?
  id_token           String?
  session_state      String?

  user               User @relation(delete: Cascade, fields: [userId], references: [id])

  @@unique([provider, providerAccountId])
  @@index([userId])
}
```

### 4. Session (NextAuth)
Session management for authenticated users.

```prisma
model Session {
  id           String   @id @default(cuid())
  sessionToken String   @unique
  userId       String
  expires      DateTime

  user         User @relation(delete: Cascade, fields: [userId], references: [id])

  @@index([userId])
}
```

### 5. Membership (Org-User Bridge)
Multi-tenant relationship with role assignment.

```prisma
model Membership {
  id               String   @id @default(cuid())
  organizationId   String
  userId           String

  // Role assignment
  role             String   @default("member")  // admin, editor, member, viewer

  // Status
  status           String   @default("active")  // active, invited, suspended
  invitedAt        DateTime?
  joinedAt         DateTime?

  // Timestamps
  createdAt        DateTime @default(now())
  updatedAt        DateTime @updatedAt

  // Relations
  organization     Organization @relation(fields: [organizationId], references: [id], onDelete: Cascade)
  user             User @relation(fields: [userId], references: [id], onDelete: Cascade)

  // Unique constraint: user can only have one membership per org
  @@unique([organizationId, userId])
  @@index([organizationId])
  @@index([userId])
  @@index([status])
}
```

### 6. Role (RBAC)
Define roles with multiple permissions.

```prisma
model Role {
  id               String   @id @default(cuid())
  organizationId   String
  name             String   // e.g., "Admin", "Editor", "Viewer"
  description      String?

  isBuiltIn        Boolean  @default(false)  // System roles can't be deleted

  // Relations
  permissions      RolePermission[]

  // Timestamps
  createdAt        DateTime @default(now())
  updatedAt        DateTime @updatedAt

  // Relations
  organization     Organization @relation(fields: [organizationId], references: [id], onDelete: Cascade)

  // Unique: one role name per organization
  @@unique([organizationId, name])
  @@index([organizationId])
}
```

### 7. Permission (RBAC)
Define granular permissions for the system.

```prisma
model Permission {
  id               String   @id @default(cuid())
  organizationId   String

  // Permission identifier
  resource         String   // e.g., "campaigns", "contacts", "analytics"
  action           String   // e.g., "create", "read", "update", "delete"
  description      String?

  // Relations
  roles            RolePermission[]

  // Timestamps
  createdAt        DateTime @default(now())
  updatedAt        DateTime @updatedAt

  // Relations
  organization     Organization @relation(fields: [organizationId], references: [id], onDelete: Cascade)

  // Unique: one permission per org per resource+action
  @@unique([organizationId, resource, action])
  @@index([organizationId])
}
```

### 8. RolePermission (M-to-M)
Junction table linking roles to permissions.

```prisma
model RolePermission {
  roleId         String
  permissionId   String

  role           Role @relation(fields: [roleId], references: [id], onDelete: Cascade)
  permission     Permission @relation(fields: [permissionId], references: [id], onDelete: Cascade)

  @@id([roleId, permissionId])
  @@index([roleId])
  @@index([permissionId])
}
```

### 9. VerificationToken (Email Verification)
For email verification and password resets.

```prisma
model VerificationToken {
  id         String   @id @default(cuid())
  email      String
  token      String   @unique
  type       String   // "email_verification", "password_reset"
  expires    DateTime

  createdAt  DateTime @default(now())

  @@index([email])
  @@index([token])
}
```

### 10. AuditLog (Compliance)
Track user actions for security and GDPR.

```prisma
model AuditLog {
  id               String   @id @default(cuid())
  organizationId   String
  userId           String

  // Action details
  action           String   // e.g., "user.created", "campaign.sent"
  resource         String   // e.g., "user", "campaign"
  resourceId       String?  // ID of affected resource
  changes          Json?    // Before/after values for changes

  // Context
  ipAddress        String?
  userAgent        String?

  // Timestamps
  createdAt        DateTime @default(now())

  // Relations
  user             User @relation(fields: [userId], references: [id])

  @@index([organizationId])
  @@index([userId])
  @@index([action])
  @@index([createdAt])
}
```

## 🚀 Implementation Steps

### Step 1: Update Prisma Schema
1. Replace existing schema with Phase 1 models above
2. Add indexes as specified
3. Validate schema syntax

### Step 2: Create Initial Migration
```bash
export DATABASE_URL="postgresql://postgres:postgres@localhost:5432/transcendence"
npx prisma migrate dev --name init_phase1
```

### Step 3: Implement Seed Data
Create `prisma/seed.ts`:
```typescript
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  // Create test organization
  const org = await prisma.organization.create({
    data: {
      name: 'Test Organization',
      slug: 'test-org',
      plan: 'pro',
    },
  });

  // Create built-in roles
  const adminRole = await prisma.role.create({
    data: {
      organizationId: org.id,
      name: 'Admin',
      description: 'Full access',
      isBuiltIn: true,
    },
  });

  console.log('Seeded:', { org, adminRole });
}

main().catch(console.error).finally(() => prisma.$disconnect());
```

### Step 4: Build API Routes
Create `src/app/api/organizations/route.ts`:
- List organizations (current user's orgs)
- Create new organization
- Update organization settings

### Step 5: Implement Middleware
Create `src/middleware.ts`:
- Extract organization from request
- Verify user has access
- Attach organization to request

### Step 6: Add TypeScript Utils
Create `src/lib/auth.ts`:
- Check user permissions
- Verify org access
- Role validation functions

## 📊 Key Database Queries

### Get User's Organizations
```typescript
const orgs = await prisma.membership.findMany({
  where: { userId: currentUserId },
  include: { organization: true },
});
```

### Check User Permission
```typescript
const hasPermission = await prisma.rolePermission.findFirst({
  where: {
    role: {
      organization: { id: orgId },
      permissions: {
        some: {
          permission: { resource, action },
        },
      },
    },
  },
});
```

### Tenant Isolation
```typescript
// All queries MUST include orgId check
const data = await prisma.someModel.findMany({
  where: {
    organizationId: currentOrgId,
    // ... other filters
  },
});
```

## ✨ Best Practices

1. **Always filter by organizationId** - Every query must verify tenant isolation
2. **Use soft deletes** - Mark `deletedAt` instead of removing records
3. **Log all changes** - Create AuditLog entries for compliance
4. **Validate permissions** - Check RBAC before any action
5. **Index org_id** - All tables need `@@index([organizationId])`

## 📝 Testing Checklist

- [ ] Organization creation works
- [ ] User can only see their organizations
- [ ] Membership RBAC system works
- [ ] Permission checks block unauthorized access
- [ ] Soft deletes work correctly
- [ ] Audit logs record all changes
- [ ] Multi-tenant isolation verified

## 🎯 Success Criteria
- ✅ Database schema deployed
- ✅ 10 core models created
- ✅ RBAC foundation working
- ✅ Multi-tenant isolation tested
- ✅ API routes for org CRUD operational
- ✅ 0 TypeScript errors in schema

---

**Estimated Time:** 4-6 hours
**Difficulty:** Medium
**Dependencies:** All completed ✅
