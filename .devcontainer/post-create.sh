#!/bin/bash

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
until pg_isready -h db -p 5432 -U ${POSTGRES_USER}; do
  echo "Waiting for database..."
  sleep 2
done

echo "✅ PostgreSQL is ready!"

# Initialize databases and extensions
echo "🔧 Setting up databases..."

# Create additional databases
PGPASSWORD=${POSTGRES_PASSWORD} psql -h db -U ${POSTGRES_USER} -d postgres -c "CREATE DATABASE ${POSTGRES_DB}_development;"
PGPASSWORD=${POSTGRES_PASSWORD} psql -h db -U ${POSTGRES_USER} -d postgres -c "CREATE DATABASE ${POSTGRES_DB}_test;"

# Grant permissions
PGPASSWORD=${POSTGRES_PASSWORD} psql -h db -U ${POSTGRES_USER} -d postgres -c "GRANT ALL PRIVILEGES ON DATABASE \"${POSTGRES_DB}_development\" TO \"${POSTGRES_USER}\";"
PGPASSWORD=${POSTGRES_PASSWORD} psql -h db -U ${POSTGRES_USER} -d postgres -c "GRANT ALL PRIVILEGES ON DATABASE \"${POSTGRES_DB}_test\" TO \"${POSTGRES_USER}\";"

# Create extensions for development database
PGPASSWORD=${POSTGRES_PASSWORD} psql -h db -U ${POSTGRES_USER} -d ${POSTGRES_DB}_development -c "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
PGPASSWORD=${POSTGRES_PASSWORD} psql -h db -U ${POSTGRES_USER} -d ${POSTGRES_DB}_development -c "CREATE EXTENSION IF NOT EXISTS \"pg_trgm\";"

# Create extensions for test database
PGPASSWORD=${POSTGRES_PASSWORD} psql -h db -U ${POSTGRES_USER} -d ${POSTGRES_DB}_test -c "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
PGPASSWORD=${POSTGRES_PASSWORD} psql -h db -U ${POSTGRES_USER} -d ${POSTGRES_DB}_test -c "CREATE EXTENSION IF NOT EXISTS \"pg_trgm\";"

echo "✅ Database setup complete!"

# Append devcontainer environment variables to workspace .env.example
echo "📄 Updating workspace .env.example with database configuration..."

echo "" >> /workspace/.env.example
echo "# Database Configuration (from devcontainer)" >> /workspace/.env.example
echo "DATABASE_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@db:5432/${POSTGRES_DB}_development" >> /workspace/.env.example
cat /workspace/.devcontainer/.env >> /workspace/.env.example

echo "✅ Updated .env.example with current database configuration"

# Initialize Claude Flow
echo "🤖 Initializing Claude Flow..."
cd /workspace
npx --yes claude-flow@alpha init

echo "✅ Claude Flow initialized!"

# Prompt user to configure Claude API key
echo ""
echo "🔑 IMPORTANT: Configure your Claude API key to use AI features"
echo "   Run the following command and follow the prompts:"
echo "   claude auth login"
echo ""
echo "   Or set your API key directly:"
echo "   export ANTHROPIC_API_KEY='your-api-key-here'"
echo ""

echo "🎉 Development environment setup complete!"
