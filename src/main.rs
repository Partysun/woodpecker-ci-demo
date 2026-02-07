use axum::{Json, Router, response::Html, routing::get};
use serde_json::json;
use std::env;

#[tokio::main]
async fn main() {
    // Get port from environment variable, default to 4000
    let port = env::var("APP_PORT")
        .unwrap_or_else(|_| "4000".to_string())
        .parse::<u16>()
        .expect("PORT must be a valid u16");

    // build our application with routes
    let app = Router::new()
        .route("/", get(handler))
        .route("/health", get(health_check));

    // run it
    let addr = format!("0.0.0.0:{}", port);
    let listener = tokio::net::TcpListener::bind(&addr).await.unwrap();
    println!("listening on {}", listener.local_addr().unwrap());
    axum::serve(listener, app).await.expect("server error");
}

async fn handler() -> Html<&'static str> {
    Html("<h1>Hello, World! Woodpecker!</h1>")
}

async fn health_check() -> Json<serde_json::Value> {
    Json(json!({
        "status": "healthy",
        "service": "woodpecker-ci-demo"
    }))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn test_handler_response() {
        let response = handler().await;
        assert_eq!(response.0, "<h1>Hello, World! Woodpecker!</h1>");
    }

    #[tokio::test]
    async fn test_health_check() {
        let response = health_check().await;
        let json = response.0;
        assert_eq!(json["status"], "healthy");
        assert_eq!(json["service"], "woodpecker-ci-demo");
    }
}
