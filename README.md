# Zoomcamp Capstone Project

This repository contains the end-to-end implementation of a data pipeline built as part of the Data Engineering Zoomcamp Capstone project. It covers data ingestion, transformation, orchestration, and visualization.

---

## 📊 Dashboard

The final dashboard provides insights derived from the processed data.

![Dashboard Screenshot](path/to/dashboard_image.png)

[🔗 View the live dashboard here](https://your-dashboard-link.com)

---

## 📁 Data

The pipeline is powered by real-world data, collected from [source name], and contains information on:

- Dataset Name
- Key columns
- Format (CSV/Parquet/etc.)
- Storage Location (e.g., GCS bucket or local directory)

---

## 🔁 Data Pipeline

The data pipeline architecture includes:

- **Ingestion**: Handled via Kestra, triggered daily via Cloud Scheduler.
- **Transformation**: Performed with `dbt` (BigQuery).
- **Orchestration**: Managed by Kestra flows for ingestion and transformation.
- **Deployment**: All components run in Docker containers on a GCP VM instance.

![Pipeline Diagram](path/to/pipeline_image.png)

---

## 🛠️ How to Replicate This Project

### Prerequisites

- GCP project
- Docker and Docker Compose
- Kestra
- dbt CLI
- Git

### Steps

1. **Clone this repository**  
   ```bash
   git clone https://github.com/stefbp066/zoomcamp_capstone.git
   cd zoomcamp_capstone
