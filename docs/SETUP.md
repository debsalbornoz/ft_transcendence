# Transcendence - Project Setup Guide

## **Prerequisites**

Before starting, ensure you have the following installed on your system:

- **Node.js** (v18.17 or later) - [Download here](https://nodejs.org/)
- **npm** (comes with Node.js) or **yarn**
- **Docker** and **Docker Compose** - [Download here](https://www.docker.com/)
- **Git** - [Download here](https://git-scm.com/)
- A code editor like **VS Code** - [Download here](https://code.visualstudio.com/)

---

## **Step 1: Install Node.js and npm**

### **Option A: Using NVM (Recommended)**

NVM (Node Version Manager) allows you to manage multiple Node.js versions:

```bash
# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Reload shell configuration
source ~/.bashrc  # or source ~/.zshrc for zsh

# Install Node.js LTS version
nvm install --lts

# Verify installation
node --version  # Should show v20.x.x or similar
npm --version   # Should show v10.x.x or similar
```

### **Option B: Using Package Manager (Ubuntu/Debian)**

```bash
# Install Node.js and npm
sudo apt update
sudo apt install -y nodejs npm

# Verify installation
node --version
npm --version
```

### **Option C: Using Official NodeSource Repository (Recommended for Ubuntu/Debian)**

```bash
# Download and install NodeSource repository
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

# Install Node.js
sudo apt-get install -y nodejs

# Verify installation
node --version
npm --version
```

---

## **Step 2: Clone the Repository**

```bash
# Clone the repository
git clone https://github.com/Dangerdrive/ft_transcendence.git
cd ft_transcendence
```

---

## **Step 3: Initialize Next.js Project**

### **Interactive Setup (Recommended)**

Run the following command and follow the prompts:

```bash
npx create-next-app@latest . --typescript --tailwind --app --eslint --src-dir --import-alias "@/*" --use-npm
```

**Configuration Options:**
- ✅ TypeScript: **Yes**
- ✅ ESLint: **Yes**
- ✅ Tailwind CSS: **Yes**
- ✅ `src/` directory: **Yes**
- ✅ App Router: **Yes** (recommended)
- ✅ Import alias: **@/*** (recommended)
- ✅ Package manager: **npm**

### **Manual Setup (Alternative)**

If you prefer to set up manually:

```bash
# Initialize npm project
npm init -y

# Install Next.js, React, and React DOM
npm install next@latest react@latest react-dom@latest

# Install TypeScript dependencies
npm install --save-dev typescript @types/react @types/node @types/react-dom

# Install Tailwind CSS
npm install --save-dev tailwindcss postcss autoprefixer
npx tailwindcss init -p

# Install ESLint
npm install --save-dev eslint eslint-config-next
```

---

## **Step 4: Project Structure**

After initialization, your project should have this structure:

```
ft_transcendence/
├── src/
│   ├── app/
│   │   ├── layout.tsx          # Root layout
│   │   ├── page.tsx            # Home page
│   │   ├── globals.css         # Global styles
│   │   └── api/                # API routes (backend)
│   ├── components/             # React components
│   ├── lib/                    # Utilities, services, business logic
│   └── types/                  # TypeScript types
├── public/                     # Static files
├── prisma/                     # Prisma schema (to be added)
├── docs/                       # Documentation
├── .env.example                # Environment variables template
├── .env.local                  # Local environment variables (gitignored)
├── .gitignore
├── next.config.js              # Next.js configuration
├── package.json
├── tailwind.config.ts          # Tailwind configuration
├── tsconfig.json               # TypeScript configuration
└── README.md
```

---

## **Step 5: Configure Environment Variables**

Create environment files:

```bash
# Create .env.local for local development
touch .env.local

# Create .env.example as a template for the team
touch .env.example
```

Add the following to `.env.example`:

```env
# Database
DATABASE_URL="postgresql://username:password@localhost:5432/transcendence?schema=public"

# NextAuth.js
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="your-secret-key-here-generate-with-openssl"

# OAuth Providers (Optional)
GOOGLE_CLIENT_ID="your-google-client-id"
GOOGLE_CLIENT_SECRET="your-google-client-secret"
GITHUB_CLIENT_ID="your-github-client-id"
GITHUB_CLIENT_SECRET="your-github-client-secret"
AUTH_42_CLIENT_ID="your-42-client-id"
AUTH_42_CLIENT_SECRET="your-42-client-secret"

# App Configuration
NODE_ENV="development"
```

Copy to `.env.local` and fill in actual values:

```bash
cp .env.example .env.local
# Edit .env.local with your actual credentials
```

**Generate NEXTAUTH_SECRET:**

```bash
openssl rand -base64 32
```

---

## **Step 6: Install Core Dependencies**

### **Database & ORM (Prisma)**

```bash
# Install Prisma
npm install prisma @prisma/client

# Initialize Prisma
npx prisma init
```

### **Authentication (NextAuth.js)**

```bash
# Install NextAuth.js v5 (Auth.js)
npm install next-auth@beta

# Install additional adapters if using database sessions
npm install @auth/prisma-adapter
```

### **Validation (Zod)**

```bash
# Install Zod for schema validation
npm install zod
```

### **UI Components (shadcn/ui)**

```bash
# Initialize shadcn/ui
npx shadcn-ui@latest init
```

Configuration options for shadcn/ui:
- Style: **Default**
- Base color: **Slate** (or your preference)
- CSS variables: **Yes**

### **Additional Utilities**

```bash
# Date manipulation
npm install date-fns

# Toast notifications
npm install sonner

# Charts for analytics
npm install recharts

# Icons
npm install lucide-react

# State management (optional)
npm install zustand
```

---

## **Step 7: Configure Tailwind CSS**

Update `tailwind.config.ts`:

```typescript
import type { Config } from "tailwindcss"

const config = {
  darkMode: ["class"],
  content: [
    './src/pages/**/*.{ts,tsx}',
    './src/components/**/*.{ts,tsx}',
    './src/app/**/*.{ts,tsx}',
  ],
  prefix: "",
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
      keyframes: {
        "accordion-down": {
          from: { height: "0" },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: "0" },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
} satisfies Config

export default config
```

---

## **Step 8: Configure Prisma Schema**

Edit `prisma/schema.prisma`:

```prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

// User Model
model User {
  id                String    @id @default(cuid())
  email             String    @unique
  emailVerified     DateTime?
  name              String?
  password          String?   // Hashed password for local auth
  avatar            String?
  role              Role      @default(END_CUSTOMER)
  twoFactorSecret   String?
  twoFactorEnabled  Boolean   @default(false)
  createdAt         DateTime  @default(now())
  updatedAt         DateTime  @updatedAt

  // Relations
  accounts          Account[]
  sessions          Session[]
  organizations     UserOrganization[]
  notifications     Notification[]
  friendsInitiated  Friend[]  @relation("FriendInitiator")
  friendsReceived   Friend[]  @relation("FriendReceiver")
}

// NextAuth.js Account Model
model Account {
  id                String  @id @default(cuid())
  userId            String
  type              String
  provider          String
  providerAccountId String
  refresh_token     String? @db.Text
  access_token      String? @db.Text
  expires_at        Int?
  token_type        String?
  scope             String?
  id_token          String? @db.Text
  session_state     String?

  user User @relation(fields: [userId], references: [id], onDelete: Cascade)

  @@unique([provider, providerAccountId])
}

// NextAuth.js Session Model
model Session {
  id           String   @id @default(cuid())
  sessionToken String   @unique
  userId       String
  expires      DateTime
  user         User     @relation(fields: [userId], references: [id], onDelete: Cascade)
}

// Organization Model (Multi-tenant)
model Organization {
  id          String   @id @default(cuid())
  name        String
  slug        String   @unique
  plan        String   @default("free")
  settings    Json?
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt

  // Relations
  users       UserOrganization[]
  campaigns   Campaign[]
}

// User-Organization Relationship (with roles)
model UserOrganization {
  id             String       @id @default(cuid())
  userId         String
  organizationId String
  role           OrgRole      @default(MEMBER)
  createdAt      DateTime     @default(now())

  user         User         @relation(fields: [userId], references: [id], onDelete: Cascade)
  organization Organization @relation(fields: [organizationId], references: [id], onDelete: Cascade)

  @@unique([userId, organizationId])
}

// Campaign Model
model Campaign {
  id             String       @id @default(cuid())
  organizationId String
  name           String
  status         CampaignStatus @default(DRAFT)
  metrics        Json?
  createdAt      DateTime     @default(now())
  updatedAt      DateTime     @updatedAt

  organization Organization @relation(fields: [organizationId], references: [id], onDelete: Cascade)
  leads        Lead[]
}

// Lead Model
model Lead {
  id         String   @id @default(cuid())
  campaignId String
  email      String
  status     String
  source     String?
  metadata   Json?
  createdAt  DateTime @default(now())
  updatedAt  DateTime @updatedAt

  campaign Campaign @relation(fields: [campaignId], references: [id], onDelete: Cascade)
  events   Event[]
}

// Event Model (for analytics)
model Event {
  id        String   @id @default(cuid())
  leadId    String
  type      String
  metadata  Json?
  timestamp DateTime @default(now())

  lead Lead @relation(fields: [leadId], references: [id], onDelete: Cascade)
}

// Notification Model
model Notification {
  id        String   @id @default(cuid())
  userId    String
  type      String
  content   String
  read      Boolean  @default(false)
  createdAt DateTime @default(now())

  user User @relation(fields: [userId], references: [id], onDelete: Cascade)
}

// Friend Model
model Friend {
  id          String       @id @default(cuid())
  userId      String
  friendId    String
  status      FriendStatus @default(PENDING)
  createdAt   DateTime     @default(now())

  user   User @relation("FriendInitiator", fields: [userId], references: [id], onDelete: Cascade)
  friend User @relation("FriendReceiver", fields: [friendId], references: [id], onDelete: Cascade)

  @@unique([userId, friendId])
}

// Enums
enum Role {
  SUPER_ADMIN
  ADMIN
  CONSULTANT
  END_CUSTOMER
}

enum OrgRole {
  OWNER
  ADMIN
  MEMBER
}

enum CampaignStatus {
  DRAFT
  ACTIVE
  PAUSED
  COMPLETED
}

enum FriendStatus {
  PENDING
  ACCEPTED
  REJECTED
}
```

---

## **Step 9: Set Up Docker**

Create `docker-compose.yml`:

```yaml
version: '3.8'

services:
  # PostgreSQL Database
  db:
    image: postgres:15-alpine
    container_name: transcendence-db
    restart: unless-stopped
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: transcendence
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - transcendence-network

  # Next.js Application (for production)
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: transcendence-app
    restart: unless-stopped
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgresql://postgres:postgres@db:5432/transcendence?schema=public
      - NEXTAUTH_URL=http://localhost:3000
      - NODE_ENV=production
    depends_on:
      - db
    networks:
      - transcendence-network
    volumes:
      - .:/app
      - /app/node_modules
      - /app/.next

volumes:
  postgres_data:

networks:
  transcendence-network:
    driver: bridge
```

Create `Dockerfile`:

```dockerfile
# Stage 1: Dependencies
FROM node:20-alpine AS deps
WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci

# Stage 2: Builder
FROM node:20-alpine AS builder
WORKDIR /app

# Copy dependencies
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Generate Prisma Client
RUN npx prisma generate

# Build Next.js application
RUN npm run build

# Stage 3: Runner
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV production

# Create non-root user
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copy necessary files
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma

USER nextjs

EXPOSE 3000

ENV PORT 3000

CMD ["node", "server.js"]
```

Create `.dockerignore`:

```
node_modules
.next
.env.local
.git
.gitignore
README.md
npm-debug.log
.DS_Store
```

---

## **Step 10: Update package.json Scripts**

Add these scripts to `package.json`:

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "prisma generate && next build",
    "start": "next start",
    "lint": "next lint",
    "db:push": "prisma db push",
    "db:migrate": "prisma migrate dev",
    "db:studio": "prisma studio",
    "db:seed": "tsx prisma/seed.ts",
    "docker:up": "docker-compose up -d",
    "docker:down": "docker-compose down",
    "docker:logs": "docker-compose logs -f"
  }
}
```

---

## **Step 11: Run Database Migrations**

```bash
# Start PostgreSQL with Docker
docker-compose up -d db

# Push the Prisma schema to the database
npx prisma db push

# Or create a migration
npx prisma migrate dev --name init

# Open Prisma Studio to view database
npx prisma studio
```

---

## **Step 12: Run the Development Server**

```bash
# Install all dependencies
npm install

# Run the development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

---

## **Step 13: Verify Setup**

Check that everything is working:

1. ✅ Next.js development server running at `http://localhost:3000`
2. ✅ PostgreSQL database running (check with `docker ps`)
3. ✅ Prisma Studio accessible at `http://localhost:5555` (run `npx prisma studio`)
4. ✅ No TypeScript errors (`npm run build`)
5. ✅ No ESLint errors (`npm run lint`)

---

## **Common Issues & Troubleshooting**

### **Issue: Port 3000 already in use**

```bash
# Find and kill process using port 3000
lsof -ti:3000 | xargs kill -9

# Or use a different port
npm run dev -- -p 3001
```

### **Issue: Database connection failed**

```bash
# Check if PostgreSQL is running
docker ps

# Restart database
docker-compose restart db

# Check DATABASE_URL in .env.local
```

### **Issue: Prisma Client not generated**

```bash
# Generate Prisma Client
npx prisma generate

# Restart TypeScript server in VS Code
# Cmd/Ctrl + Shift + P -> "TypeScript: Restart TS Server"
```

---

## **Next Steps**

1. ✅ Read [Next.js Documentation](https://nextjs.org/docs)
2. ✅ Read [Prisma Documentation](https://www.prisma.io/docs)
3. ✅ Set up NextAuth.js (see `docs/AUTHENTICATION.md`)
4. ✅ Create your first API route
5. ✅ Build the design system components
6. ✅ Implement RBAC middleware

---

## **Useful Commands**

```bash
# Development
npm run dev              # Start development server
npm run build            # Build for production
npm run start            # Start production server
npm run lint             # Run ESLint

# Database
npx prisma studio        # Open Prisma Studio
npx prisma db push       # Push schema to database
npx prisma migrate dev   # Create migration
npx prisma migrate reset # Reset database

# Docker
docker-compose up -d     # Start all services
docker-compose down      # Stop all services
docker-compose logs -f   # View logs
docker-compose ps        # List running containers

# Install shadcn/ui components
npx shadcn-ui@latest add button
npx shadcn-ui@latest add input
npx shadcn-ui@latest add card
```

---

## **Resources**

- [Next.js Documentation](https://nextjs.org/docs)
- [React Documentation](https://react.dev)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Prisma Documentation](https://www.prisma.io/docs)
- [NextAuth.js Documentation](https://next-auth.js.org/)
- [shadcn/ui Documentation](https://ui.shadcn.com/)

---

**Project maintained by the ft_transcendence team**  
For questions or issues, contact the team via Discord or GitHub Issues.
