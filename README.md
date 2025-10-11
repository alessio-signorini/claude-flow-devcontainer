# Claude Flow Development Environment

This development environment includes:

- **Ruby**: Latest stable version with Rails
- **Node.js**: Latest LTS with npm and yarn
- **PostgreSQL**: Version 15 with pre-configured databases
- **Redis**: Version 7 for caching and background jobs
- **Claude Flow CLI**: For AI-powered development workflows (automatically initialized)

## Services

The following services are available:

- **Rails App**: http://localhost:3000
- **PostgreSQL**: localhost:5432 (user: postgres, password: postgres)
- **Redis**: localhost:6379
- **pgAdmin**: http://localhost:8080 (admin@example.com / admin)
- **Redis Commander**: http://localhost:8081

## Claude API Key Setup

**Required**: Before using Claude Flow, you need to configure your Anthropic API key.

**Option 1 - Environment Variable (Recommended):**
```bash
export ANTHROPIC_API_KEY='your-api-key-here'
```

**Option 2 - Claude CLI Authentication:**
```bash
claude auth login
```

Once configured, Claude Flow will work automatically with AI-powered features.

## Getting Started

**Note**: Claude Flow is automatically initialized when the dev container starts. Make sure to configure your API key (see above) before using AI features.

1. **Initialize a new Rails app:**
   ```bash
   rails new my_app --database=postgresql --skip-git
   cd my_app
   ```

2. **Configure database connection** in `config/database.yml`:
   ```yaml
   development:
     adapter: postgresql
     encoding: unicode
     database: postgres
     pool: 5
     username: postgres
     password: postgres
     host: db
     port: 5432
   ```

3. **Set up the database:**
   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Start the Rails server:**
   ```bash
   rails server -b 0.0.0.0
   ```

## Claude Flow Usage

Claude Flow CLI is pre-installed and automatically initialized. You can use it to:

- Generate code with AI assistance
- Automate development workflows
- Integrate AI into your development process

For more information, run:
```bash
claude-flow --help
```

## Useful Commands

- `bundle install` - Install Ruby gems
- `npm install` - Install Node.js packages
- `rails generate` - Generate Rails components
- `redis-cli` - Connect to Redis
- `psql -h db -U postgres -d postgres` - Connect to PostgreSQL

Happy coding! 🎉
