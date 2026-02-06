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

**With Docker Compose:**

```bash
docker-compose up
```

The application listens on `http://localhost:4000` by default. Override with:

```bash
APP_PORT=8080 cargo run
```

## API Endpoints

### GET `/`

Returns an HTML greeting message.

**Response:**

```html
<h1>Hello, World! Woodpecker!</h1>
```

### GET `/health`

Returns application health status.

**Response:**

```json
{
  "status": "healthy",
  "service": "woodpecker-ci-demo"
}
```

## Development

### Run Unit Tests

```bash
cargo test
```

### Run Integration Tests

Requires the application to be running on `http://localhost:4000`:

```bash
make test
```

Or manually:

```bash
hurl --test --color --variable host=http://localhost:4000 tests/*.hurl
```

### Build for Production

```bash
cargo build --release
```

Docker image (multi-stage build):

```bash
docker build -t woodpecker-ci-demo .
```

## CI/CD Pipeline

### Test Pipeline (`.woodpecker/test.yaml`)

Runs on every push and pull request to `master` branch:

- Tests on **Rust stable** and **nightly**
- Builds with `cargo build`
- Tests with `cargo test`
- Parallelized with `-j 4` flag

### Docker Pipeline (`.woodpecker/docker.yaml`)

Builds Docker image and runs smoke integration tests:

1. **Build**: Constructs Docker image
2. **Run**: Launches container with service endpoint
3. **Smoke Tests**: Validates HTTP endpoints with Hurl
4. **Push**: Uploads to registry (requires credentials)

### Deployment Pipeline (`.woodpecker/deploy.yaml`)

Triggered on deployment events:

- Authenticates with container registry
- Executes deployment script from secrets

## Running the Pipeline Locally

Execute the full CI pipeline locally:

```bash
make ci
```

Requires `woodpecker-cli` and `.secrets.yaml` file.

Execute one workflow:

```bash
woodpecker-cli exec --repo-trusted-volumes --secrets-file=".secrets.yaml" .woodpecker/test.yaml --repo-path .
```

## Configuration

### Docker Registry Secrets

Set in `.secrets.yaml` for CI/CD:

- `docker_username`: Registry username
- `docker_password`: Registry password
- `secret_registry_base_path`: Registry URL
- `deploy_wci_script`: Deployment script path on woodpecker ci agent with local backend

## License

All code in this repository is dual-licensed under either:

- MIT License ([LICENSE-MIT](LICENSE-MIT) or [http://opensource.org/licenses/MIT](http://opensource.org/licenses/MIT))
- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE)
  or [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0))

at your option.
This means you can select the license you prefer!
This dual-licensing approach is the de-facto standard in the Rust ecosystem and there
are [very good reasons](https://github.com/bevyengine/bevy/issues/2373) to include both.
