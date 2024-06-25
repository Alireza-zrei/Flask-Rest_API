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
  "__inputs": [
    {
      "name": "DS_PROMETHEUS",
      "label": "Prometheus",
      "description": "Flask Metrics",
      "type": "datasource",
      "pluginId": "prometheus",
      "pluginName": "Prometheus"
    }
  ],
  "__elements": [],
  "__requires": [
    {
      "type": "panel",
      "id": "bargauge",
      "name": "Bar gauge",
      "version": ""
    },
    {
      "type": "grafana",
      "id": "grafana",
      "name": "Grafana",
      "version": "8.4.3"
    },
    {
      "type": "datasource",
      "id": "prometheus",
      "name": "Prometheus",
      "version": "1.0.0"
    },
    {
      "type": "panel",
      "id": "stat",
      "name": "Stat",
      "version": ""
    },
    {
      "type": "panel",
      "id": "table",
      "name": "Table",
      "version": ""
    },
    {
      "type": "panel",
      "id": "timeseries",
      "name": "Time series",
      "version": ""
    }
  ],
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": "-- Grafana --",
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "target": {
          "limit": 100,
          "matchAny": false,
          "tags": [],
          "type": "dashboard"
        },
        "type": "dashboard"
      }
    ]
  },
  "editable": true,
  "fiscalYearStartMonth": 0,
  "graphTooltip": 0,
  "id": null,
  "iteration": 1650043456106,
  "links": [],
  "liveNow": false,
  "panels": [
    {
      "datasource": {
        "type": "prometheus",
        "uid": "${DS_PROMETHEUS}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 6,
        "x": 0,
        "y": 0
      },
      "id": 19,
      "options": {
        "colorMode": "value",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "auto",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.4.3",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "exemplar": true,
          "expr": "sum (flask_request_status_total{app_name=\"$app_name\"})",
          "interval": "",
          "legendFormat": "",
          "refId": "A"
        }
      ],
      "timeFrom": "24h",
      "title": "Total Requests",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "${DS_PROMETHEUS}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 6,
        "x": 6,
        "y": 0
      },
      "id": 21,
      "options": {
        "colorMode": "value",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "auto",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.4.3",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "exemplar": true,
          "expr": "sum (flask_request_status_total{app_name=\"$app_name\"}) by(status)",
          "interval": "",
          "legendFormat": "HTTP Status: {{status}}",
          "refId": "A"
        }
      ],
      "timeFrom": "24h",
      "title": "Requests Per Status Code",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "${DS_PROMETHEUS}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "continuous-GrYlRd"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              }
            ]
          },
          "unit": "s"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 0
      },
      "id": 23,
      "options": {
        "displayMode": "lcd",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "showUnfilled": true
      },
      "pluginVersion": "8.4.3",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "exemplar": true,
          "expr": "flask_request_duration_seconds_sum{app_name=\"flask-monitoring\"} / flask_request_duration_seconds_count{app_name=\"flask-monitoring\"}",
          "interval": "",
          "legendFormat": "{{method}} {{endpoint}}",
          "refId": "A"
        }
      ],
      "title": "Requests Average Duration",
      "type": "bargauge"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "${DS_PROMETHEUS}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 8
      },
      "id": 10,
      "options": {
        "legend": {
          "calcs": [
            "last"
          ],
          "displayMode": "list",
          "placement": "right"
        },
        "tooltip": {
          "mode": "single",
          "sort": "none"
        }
      },
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "exemplar": true,
          "expr": "flask_request_duration_seconds_count{app_name=\"$app_name\"}",
          "interval": "",
          "legendFormat": "{{method}} {{endpoint}}",
          "refId": "A"
        }
      ],
      "title": "Requests Count",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "${DS_PROMETHEUS}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "reqps"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 8
      },
      "id": 6,
      "options": {
        "legend": {
          "calcs": [
            "last"
          ],
          "displayMode": "list",
          "placement": "right"
        },
        "tooltip": {
          "mode": "single",
          "sort": "none"
        }
      },
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "exemplar": true,
          "expr": "rate(flask_request_duration_seconds_count{app_name=\"flask-monitoring\"}[1m])",
          "interval": "",
          "legendFormat": "{{endpoint}}",
          "refId": "A"
        }
      ],
      "title": "Requests Per Second",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "${DS_PROMETHEUS}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisLabel": "",
            "axisPlacement": "auto",
            "axisSoftMax": 1,
            "barAlignment": 0,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "area"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "percentage",
            "steps": [
              {
                "color": "dark-red",
                "value": null
              },
              {
                "color": "green",
                "value": 80
              }
            ]
          },
          "unit": "percentunit"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 16
      },
      "id": 2,
      "options": {
        "legend": {
          "calcs": [
            "last"
          ],
          "displayMode": "list",
          "placement": "right"
        },
        "tooltip": {
          "mode": "single",
          "sort": "none"
        }
      },
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "exemplar": true,
          "expr": "sum(flask_request_status_total{app_name=\"$app_name\", status=~\"2.*\"}) by(endpoint, method) / sum(flask_request_status_total{app_name=\"$app_name\"}) by(endpoint, method)",
          "hide": false,
          "interval": "",
          "legendFormat": "{{method}} {{endpoint}} ",
          "refId": "A"
        }
      ],
      "title": "Percent of 2xx Requests",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "${DS_PROMETHEUS}"
      },
      "description": "",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisLabel": "",
            "axisPlacement": "auto",
            "axisSoftMax": 1,
            "barAlignment": 0,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "area"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "percentage",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 10
              }
            ]
          },
          "unit": "percentunit"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 16
      },
      "id": 17,
      "options": {
        "legend": {
          "calcs": [
            "last"
          ],
          "displayMode": "list",
          "placement": "right"
        },
        "tooltip": {
          "mode": "single",
          "sort": "none"
        }
      },
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "exemplar": true,
          "expr": "sum(flask_request_status_total{app_name=\"$app_name\", status=~\"5.*\"}) by(endpoint, method) / sum(flask_request_status_total{app_name=\"$app_name\"}) by(endpoint, method)",
          "hide": false,
          "interval": "",
          "legendFormat": "{{method}} {{endpoint}} ",
          "refId": "A"
        }
      ],
      "title": "Percent of 5xx Requests",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "${DS_PROMETHEUS}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "s"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 24
      },
      "id": 4,
      "options": {
        "legend": {
          "calcs": [
            "last"
          ],
          "displayMode": "table",
          "placement": "right"
        },
        "tooltip": {
          "mode": "single",
          "sort": "none"
        }
      },
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "exemplar": true,
          "expr": "flask_request_duration_seconds_sum{app_name=\"$app_name\"} / flask_request_duration_seconds_count{app_name=\"$app_name\"}",
          "hide": false,
          "interval": "",
          "legendFormat": "{{endpoint}}",
          "refId": "A"
        }
      ],
      "title": "Request Average Duration",
      "transformations": [
        {
          "id": "seriesToColumns",
          "options": {}
        }
      ],
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "${DS_PROMETHEUS}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "displayMode": "auto"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "s"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 24
      },
      "id": 8,
      "options": {
        "footer": {
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true
      },
      "pluginVersion": "8.4.3",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "exemplar": false,
          "expr": "flask_request_duration_seconds{app_name=\"$app_name\", quantile='0.5'}",
          "format": "table",
          "instant": true,
          "interval": "",
          "legendFormat": "",
          "refId": "PR 50"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "exemplar": false,
          "expr": "flask_request_duration_seconds{app_name=\"$app_name\", quantile='0.9'}",
          "format": "table",
          "hide": false,
          "instant": true,
          "interval": "",
          "legendFormat": "",
          "refId": "PR 90"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "exemplar": false,
          "expr": "flask_request_duration_seconds{app_name=\"$app_name\", quantile='0.99'}",
          "format": "table",
          "hide": false,
          "instant": true,
          "interval": "",
          "legendFormat": "",
          "refId": "PR 99"
        }
      ],
      "title": "Request Duration Distribution",
      "transformations": [
        {
          "id": "seriesToColumns",
          "options": {
            "byField": "endpoint"
          }
        },
        {
          "id": "organize",
          "options": {
            "excludeByName": {
              "Time 1": true,
              "Time 2": true,
              "Time 3": true,
              "Value #PR 50": false,
              "__name__ 1": true,
              "__name__ 2": true,
              "__name__ 3": true,
              "app_name 1": true,
              "app_name 2": true,
              "app_name 3": true,
              "instance 1": true,
              "instance 2": true,
              "instance 3": true,
              "job 1": true,
              "job 2": true,
              "job 3": true,
              "method 1": false,
              "method 2": true,
              "method 3": true,
              "quantile 1": true,
              "quantile 2": true,
              "quantile 3": true
            },
            "indexByName": {},
            "renameByName": {
              "Value #PR 50": "PR 50 (s)",
              "Value #PR 90": "PR 90 (s)",
              "Value #PR 99": "PR 99 (s)",
              "method 1": "Method"
            }
          }
        }
      ],
      "type": "table"
    }
  ],
  "refresh": "5s",
  "schemaVersion": 35,
  "style": "dark",
  "tags": [],
  "templating": {
    "list": [
      {
        "current": {},
        "datasource": {
          "type": "prometheus",
          "uid": "${DS_PROMETHEUS}"
        },
        "definition": "label_values(flask_info{}, app_name)",
        "hide": 0,
        "includeAll": false,
        "label": "Application Name",
        "multi": false,
        "name": "app_name",
        "options": [],
        "query": {
          "query": "label_values(flask_info{}, app_name)",
          "refId": "StandardVariableQuery"
        },
        "refresh": 1,
        "regex": "",
        "skipUrlSync": false,
        "sort": 0,
        "type": "query"
      }
    ]
  },
  "time": {
    "from": "now-5m",
    "to": "now"
  },
  "timepicker": {},
  "timezone": "",
  "title": "Flask Monitoring",
  "uid": "NgPjSHsnz",
  "version": 1,
  "weekStart": "",
  "gnetId": 16111,
  "description": "Monitor Flask application through custom StatsD metrics with Prometheus and Grafana."
}

```
