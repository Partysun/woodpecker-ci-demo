# Build
FROM rust:1.93-slim AS builder

WORKDIR /app

ENV CARGO_TERM_COLOR=always

COPY Cargo.toml Cargo.lock ./
COPY src ./src

RUN cargo build --release

# Runtime
FROM debian:bookworm-slim AS runtime

RUN apt-get update && apt-get install -y \
  ca-certificates \
  curl \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=builder /app/target/release/woodpecker-ci-demo /app/

ARG PORT=4000
EXPOSE ${PORT}
ENV APP_PORT=${PORT}

CMD ["/app/woodpecker-ci-demo"]
