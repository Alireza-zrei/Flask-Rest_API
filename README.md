# Flask REST API with Prometheus Monitoring

This project is a simple Flask REST API application that includes Prometheus metrics for monitoring. The application exposes a `/detect` endpoint and a `/metrics` endpoint for Prometheus to scrape metrics.

## Features

- **Flask REST API**: Provides a `/detect` endpoint that logs the HTTP request type and returns a JSON response.
- **Database Integration**: Uses PostgreSQL for logging requests.
- **Prometheus Monitoring**: Integrates Prometheus for monitoring application metrics.
- **Dockerized**: The application, database, and Prometheus are containerized using Docker.

## Requirements

- Docker
- Docker Compose

## Setup

1. **Clone the Repository**

    ```sh
    git clone https://github.com/Alireza-zrei/Flask-Rest_API.git
    cd Flask-Rest_API
    ```

2. **Build and Run the Containers**

    Build the Docker images and run the containers using Docker Compose:

    ```sh
    docker-compose up -d
    ```

    This will start the Flask application on `localhost:5000`, PostgreSQL on the default port, and Prometheus on `localhost:9090`.

## Endpoints

- **Flask API**: `http://localhost:5000/detect`
- **Prometheus Metrics**: `http://localhost:5000/metrics`
- **Prometheus Dashboard**: `http://localhost:9090`

## Configuration

### Prometheus Configuration

The `prometheus.yml` file configures Prometheus to scrape metrics from the Flask application:

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'flask-app'
    static_configs:
      - targets: ['web:5000']
```
### Example Grafana Dashboard

To monitor the Flask application in Grafana, import the following JSON into Grafana:


```sh
{
  "dashboard": {
    "annotations": {
      "list": []
    },
    "editable": true,
    "gnetId": null,
    "graphTooltip": 0,
    "id": null,
    "links": [],
    "panels": [
      {
        "datasource": "Prometheus",
        "gridPos": {
          "h": 8,
          "w": 12,
          "x": 0,
          "y": 0
        },
        "id": 1,
        "title": "Request Count",
        "type": "stat",
        "targets": [
          {
            "expr": "sum(app_request_count) by (method)",
            "interval": "",
            "legendFormat": "{{method}}",
            "refId": "A"
          }
        ]
      },
      {
        "datasource": "Prometheus",
        "gridPos": {
          "h": 8,
          "w": 12,
          "x": 12,
          "y": 0
        },
        "id": 2,
        "title": "Request Latency",
        "type": "stat",
        "targets": [
          {
            "expr": "histogram_quantile(0.95, sum(rate(app_request_latency_seconds_bucket[5m])) by (le, method))",
            "interval": "",
            "legendFormat": "{{method}}",
            "refId": "A"
          }
        ]
      }
    ],
    "refresh": "5s",
    "schemaVersion": 26,
    "style": "dark",
    "tags": [],
    "templating": {
      "list": []
    },
    "time": {
      "from": "now-15m",
      "to": "now"
    },
    "timepicker": {
      "refresh_intervals": [
        "5s",
        "10s",
        "30s",
        "1m",
        "5m",
        "15m",
        "30m",
        "1h",
        "2h",
        "1d"
      ]
    },
    "timezone": "",
    "title": "Flask App Dashboard",
    "uid": null,
    "version": 1
  }
}


```
