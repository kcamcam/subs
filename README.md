![Continuous Integration](https://github.com/kcamcam/subs/workflows/Continuous%20Integration/badge.svg)
[![BCH compliance](https://bettercodehub.com/edge/badge/kcamcam/subs?branch=master&token=d08e95874186b52849dd864c35495d31829e0dc9)](https://bettercodehub.com/)
[![Maintainability](https://api.codeclimate.com/v1/badges/faa5692d537fa10bc4ce/maintainability)](https://codeclimate.com/github/kcamcam/subs/maintainability)
[![codecov](https://codecov.io/gh/kcamcam/subs/branch/master/graph/badge.svg?token=EG1B7MIITW)](https://codecov.io/gh/kcamcam/subs)

# Subs
A subscriptions tracker.

# About
- Ruby v3.0.0
- Rails v 6.0.3
- Postgres 13.1
- Sidekiq 6.1.2 (Redis 6.0.10)
- Bootstrap v5

Ruby  
```bash
# rvm list
rvm get stable
rvm install ruby-3.0.0
rvm use 3.0.0
```

Redis  
```bash
# redis-server --version
brew install redis
brew services start redis
```

Postgres  
```bash
# psql --version
brew install postgre
brew services start postgres
```

# Development
```bash
rails s
sidekiq
# optional
ruby ./bin/webpack-dev-server
```

# Test
```bash
rspec
open coverage/index.html
```
# Production