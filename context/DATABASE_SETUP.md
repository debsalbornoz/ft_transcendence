# Database Setup Guide

## Overview

This guide covers the complete PostgreSQL database setup for the ft_transcendence project, including user creation, database initialization, and migration steps.

## Prerequisites

- PostgreSQL 16+ installed on your system
- `psql` CLI tool available
- Sudo access for system commands

## Step 1: Start PostgreSQL Service

```bash
# Check status
sudo systemctl status postgresql

# Start service
sudo systemctl start postgresql

# Verify PostgreSQL is running
sudo -u postgres psql -c "SELECT version();"
```

Expected output: PostgreSQL version info

## Step 2: Create Database User

Create a dedicated user for the project with createdb privileges:

```bash
sudo -u postgres psql -c "CREATE USER ft_transcendence WITH PASSWORD 'password123' CREATEDB;"
```

**User credentials:**
- Username: `ft_transcendence`
- Password: `password123`
- Privileges: Database creation

## Step 3: Create Database

Create the `transcendence` database owned by the new user:

```bash
sudo -u postgres psql -c "CREATE DATABASE transcendence OWNER ft_transcendence;"
```

## Step 4: Verify Connection

Test the connection with new credentials:

```bash
PGPASSWORD='password123' psql -U ft_transcendence -h localhost -d transcendence -c "SELECT 1;"
```

Expected output: `1` (single row result)

## Step 5: Update Environment Variables

Update `.env.local` with the database connection string:

```env
DATABASE_URL="postgresql://ft_transcendence:password123@localhost:5432/transcendence"
```

## Step 6: Run Prisma Migration

Initialize the database schema using Prisma:

```bash
cd /home/fde-alen/Projetos/ft_transcendence/project

# Export DATABASE_URL
export DATABASE_URL="postgresql://ft_transcendence:password123@localhost:5432/transcendence"

# Run migration
npx prisma migrate dev --name init_phase1
```

Expected output:
```
Loaded Prisma config from prisma.config.js.
Prisma schema loaded from prisma/schema.prisma.
Datasource "db": PostgreSQL database "transcendence", schema "public" at "localhost:5432"

Applying migration `20260130234022_init_phase1`
Your database is now in sync with your schema.
```

## Step 7: Verify Database Tables

List all created tables:

```bash
PGPASSWORD='password123' psql -U ft_transcendence -h localhost -d transcendence -c "\dt"
```

Expected tables:
- Account (NextAuth accounts)
- Campaign (Campaign management)
- Event (Event tracking)
- Friend (Friend relationships)
- Lead (Lead management)
- Notification (User notifications)
- Organization (Multi-tenant organizations)
- Session (NextAuth sessions)
- User (User profiles)
- UserOrganization (User-Org relationships)
- _prisma_migrations (Migration history)

## Connection String Reference

**Format:**
```
postgresql://[user]:[password]@[host]:[port]/[database]
```

**For this project:**
```
postgresql://ft_transcendence:password123@localhost:5432/transcendence
```

## Troubleshooting

### Authentication Failed
```
Error: P1000: Authentication failed against database server
```

**Solution:** Verify credentials are correct in `.env.local` and user was created with correct password.

### Password Authentication Failed

If using `psql` directly and password authentication fails:

```bash
# Reset password
sudo -u postgres psql -c "ALTER USER ft_transcendence WITH PASSWORD 'password123';"

# Test connection
PGPASSWORD='password123' psql -U ft_transcendence -h localhost -d transcendence -c "SELECT 1;"
```

### Cannot Connect to Server

```
Error: connection to server at "localhost" (127.0.0.1), port 5432 failed
```

**Solution:** Ensure PostgreSQL service is running:
```bash
sudo systemctl start postgresql
sudo systemctl status postgresql
```

### Database Already Exists

If the database already exists and you want to reset:

```bash
# Drop existing database
sudo -u postgres psql -c "DROP DATABASE IF EXISTS transcendence;"

# Recreate
sudo -u postgres psql -c "CREATE DATABASE transcendence OWNER ft_transcendence;"

# Re-run migrations
npx prisma migrate dev --name init_phase1
```

## Database Schema

The migration creates the following tables for Phase 1 (Organizations & RBAC):

### Core Tables

1. **User**
   - id (String, primary key)
   - email (String, unique)
   - name (String, optional)
   - password (String, hashed)
   - twoFactorSecret, twoFactorEnabled
   - createdAt, updatedAt

2. **Organization**
   - id (String, primary key)
   - name (String)
   - slug (String, unique)
   - plan (String, default: "free")
   - settings (Json, optional)
   - createdAt, updatedAt

3. **UserOrganization**
   - id (String, primary key)
   - userId (foreign key)
   - organizationId (foreign key)
   - role (enum: OWNER, ADMIN, MEMBER)
   - createdAt

### Authentication Tables (NextAuth.js)

4. **Account**
   - id (String, primary key)
   - userId (foreign key)
   - provider, providerAccountId
   - access_token, refresh_token, expires_at
   - (OAuth provider integration)

5. **Session**
   - id (String, primary key)
   - sessionToken (String, unique)
   - userId (foreign key)
   - expires (DateTime)

### Notifications & Social

6. **Notification**
   - id (String, primary key)
   - userId (foreign key)
   - type, content
   - read (Boolean)
   - createdAt

7. **Friend**
   - id (String, primary key)
   - userId, friendId (foreign keys)
   - status (enum: PENDING, ACCEPTED, REJECTED)

### Business Domain Tables

8. **Campaign**
   - id (String, primary key)
   - organizationId (foreign key)
   - name, status (enum: DRAFT, ACTIVE, PAUSED, COMPLETED)
   - metrics (Json)
   - createdAt, updatedAt

9. **Lead**
   - id (String, primary key)
   - campaignId (foreign key)
   - email, status, source
   - metadata (Json)

10. **Event**
    - id (String, primary key)
    - leadId (foreign key)
    - type, metadata
    - timestamp

## Managing the Database

### Backup Database

```bash
PGPASSWORD='password123' pg_dump -U ft_transcendence -h localhost transcendence > backup.sql
```

### Restore from Backup

```bash
PGPASSWORD='password123' psql -U ft_transcendence -h localhost transcendence < backup.sql
```

### Connect Interactively

```bash
PGPASSWORD='password123' psql -U ft_transcendence -h localhost -d transcendence
```

Then run SQL commands:
```sql
-- List tables
\dt

-- Describe table structure
\d User

-- Exit
\q
```

### Reset Migrations

If you need to reset and start fresh:

```bash
# Delete migrations folder
rm -rf prisma/migrations

# Delete database
sudo -u postgres psql -c "DROP DATABASE transcendence;"

# Recreate
sudo -u postgres psql -c "CREATE DATABASE transcendence OWNER ft_transcendence;"

# Run initial migration
npx prisma migrate dev --name init_phase1
```

## Prisma Commands Reference

```bash
# Generate Prisma Client
npx prisma generate

# Open Prisma Studio (database GUI)
npm run db:studio

# Create a migration
npx prisma migrate dev --name <migration_name>

# Apply migrations only (no client generation)
npx prisma migrate deploy

# View migration status
npx prisma migrate status

# Reset database (DESTRUCTIVE)
npx prisma migrate reset
```

## Production Considerations

⚠️ **Security Notes:**

1. **Change Default Credentials** - Never use `password123` in production
2. **Use Environment Variables** - Store credentials in `.env` files (never commit)
3. **Enable SSL Connections** - Use SSL certificates for remote connections
4. **Restrict User Permissions** - Use principle of least privilege
5. **Regular Backups** - Automate daily backups
6. **Monitor Connections** - Log and monitor database access

## Next Steps

1. ✅ Database configured and ready
2. ✅ Phase 1 schema migrated
3. ⏳ Seed initial data (organizations, users, roles)
4. ⏳ Implement API endpoints
5. ⏳ Set up Docker configuration

---

**Last Updated:** January 30, 2026
**Database Version:** PostgreSQL 16
**Prisma Version:** 7.3.0
