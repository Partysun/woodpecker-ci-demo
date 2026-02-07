# Woodpecker CI Demo

A minimal Rust web application demonstrating CI/CD pipelines with [Woodpecker CI](https://woodpecker-ci.org/).

## Overview

This project is a simple HTTP API built with [Axum](https://github.com/tokio-rs/axum) that showcases:

- **Multi-stage CI pipeline**: Unit tests, Docker image building, integration tests, and deployment
- **Health checks**: Built-in health check endpoint and Docker compose healthcheck configuration
- **Integration testing**: HTTP tests using [Hurl](https://hurl.dev/)
- **Local CI execution**: Run the full pipeline locally with `woodpecker-cli`

## Quick Start

### Prerequisites

- **Rust 1.93+** (or Docker)
- **Hurl** (for integration tests)
- **Woodpecker CLI** (for local CI execution)
- **Docker & Docker Compose** (for containerized development)

### Running Locally

**With Cargo:**

```bash
cargo run
```

**Or with Docker Compose:**

```bash
docker-compose up
```

The application listens on `http://localhost:4000` by default. Override with:

```bash
APP_PORT=8080 cargo run
```

You can use mise for managing requirements, tools and tasks:

```bash

```

mise tasks

Name Description
build Build Docker image, run integration tests, and push to registry using Woodpecker CI
lint Format and lint Rust code
test Run tests using Woodpecker CI
test-hurl Run integration tests using Hurl against local server (<http://localhost:4000>)

## Configuration

### Woodpecker Secrets

Set in `.secrets.yaml` for local running CI/CD pipeline:

- `docker_username`: Registry username
- `docker_password`: Registry password
- `secret_registry_base_path`: Registry URL
- `deploy_wci_script`: Deployment script path on woodpecker ci agent with local backend

## License

All code in this repository is dual-licensed under either:

- MIT License ([LICENSE-MIT](LICENSE-MIT) or [http://opensource.org/licenses/MIT](http://opensource.org/licenses/MIT))
- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE)
  or [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0))
