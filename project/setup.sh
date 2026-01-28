#!/bin/bash

# Transcendence Project Setup Script
# This script automates the initial setup of the project

set -e  # Exit on error

echo "🚀 Transcendence Project Setup Script"
echo "======================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Check if Node.js is installed
echo "Checking prerequisites..."
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed"
    print_info "Please install Node.js first:"
    echo ""
    echo "  Option 1 - Using NodeSource (Recommended):"
    echo "    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -"
    echo "    sudo apt-get install -y nodejs"
    echo ""
    echo "  Option 2 - Using NVM:"
    echo "    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
    echo "    source ~/.bashrc"
    echo "    nvm install --lts"
    echo ""
    exit 1
else
    NODE_VERSION=$(node --version)
    NPM_VERSION=$(npm --version)
    print_success "Node.js $NODE_VERSION installed"
    print_success "npm $NPM_VERSION installed"
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed"
    print_info "Please install Docker: https://docs.docker.com/get-docker/"
    exit 1
else
    DOCKER_VERSION=$(docker --version)
    print_success "Docker installed: $DOCKER_VERSION"
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose is not installed"
    print_info "Please install Docker Compose: https://docs.docker.com/compose/install/"
    exit 1
else
    COMPOSE_VERSION=$(docker-compose --version)
    print_success "Docker Compose installed: $COMPOSE_VERSION"
fi

echo ""
echo "📦 Installing project dependencies..."

# Install npm dependencies
if [ -f "package.json" ]; then
    print_info "Found package.json, installing dependencies..."
    npm install
    print_success "Dependencies installed"
else
    print_info "No package.json found. Please run this after Next.js initialization."
fi

echo ""
echo "🔧 Setting up environment variables..."

# Create .env.local if it doesn't exist
if [ ! -f ".env.local" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env.local
        print_success "Created .env.local from .env.example"
        print_info "Please edit .env.local with your actual credentials"
        
        # Generate NEXTAUTH_SECRET
        if command -v openssl &> /dev/null; then
            SECRET=$(openssl rand -base64 32)
            sed -i "s/your-secret-key-here-generate-with-openssl/$SECRET/" .env.local 2>/dev/null || \
            sed -i '' "s/your-secret-key-here-generate-with-openssl/$SECRET/" .env.local
            print_success "Generated NEXTAUTH_SECRET"
        else
            print_info "OpenSSL not found. Please generate NEXTAUTH_SECRET manually:"
            echo "  openssl rand -base64 32"
        fi
    else
        print_info "No .env.example found. Skipping environment setup."
    fi
else
    print_info ".env.local already exists, skipping..."
fi

echo ""
echo "🐳 Starting Docker containers..."

# Start Docker containers
if [ -f "docker-compose.yml" ]; then
    docker-compose up -d db
    print_success "Database container started"
    
    # Wait for database to be ready
    print_info "Waiting for database to be ready..."
    sleep 5
else
    print_info "No docker-compose.yml found. Skipping Docker setup."
fi

echo ""
echo "🗄️  Setting up database..."

# Check if Prisma is installed
if [ -f "prisma/schema.prisma" ]; then
    if command -v npx &> /dev/null; then
        print_info "Generating Prisma Client..."
        npx prisma generate
        print_success "Prisma Client generated"
        
        print_info "Pushing schema to database..."
        npx prisma db push --accept-data-loss
        print_success "Database schema updated"
    else
        print_info "npx not found. Please run 'npx prisma db push' manually."
    fi
else
    print_info "No Prisma schema found. Skipping database setup."
fi

echo ""
echo "✨ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Edit .env.local with your actual credentials"
echo "  2. Run 'npm run dev' to start the development server"
echo "  3. Open http://localhost:3000 in your browser"
echo "  4. (Optional) Run 'npx prisma studio' to view the database"
echo ""
echo "For more information, see docs/QUICK_START.md"
echo ""
print_success "Happy coding! 🎉"
