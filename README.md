# Zoomcamp Capstone Project

This repository contains the end-to-end implementation of a data pipeline built as part of the Data Engineering Zoomcamp Capstone project. It covers data ingestion, transformation, orchestration, and visualization.

---

## 📊 Dashboard

The final dashboard provides insights derived from the processed data.

![Dashboard Screenshot](path/to/dashboard_image.png)

[🔗 View the live dashboard here](https://lookerstudio.google.com/s/rDS0l2RY0Wo)

---

## 📁 Data

The pipeline is powered by real-world data, collected from [Open-Meteo](https://open-meteo.com/) providing API calls without needing keys. The format of the original files are in `json` format, later converted into Parquet for uploading into a GCS bucket.

---

## 🔁 Data Pipeline

The data pipeline architecture includes:

- **Ingestion**: Handled via Kestra, triggered daily at midnight. Kestra flow [ke-openmeteo-api_ingest.yml](https://github.com/stefbp066/zoomcamp_capstone/blob/main/code/kestra/ke-openmeteo-api_ingest.yml) would make a call to the API requesting specific elements of their data resulting in a `json`, then Kestra would handle the conversion into a parquet and then upload it to GCS, then also merge that into a BigQuery table. To get the Scheduler working on turning the VM on before midnight, a service account is needed with the `Compute Instance Admin (v1)` role. I personally chose to turn on the VM at 11:40 PM and turned it off at 12:15 AM. Ideally, it would turn off after the Kestra ingestion flow is completed.
- **Transformation**: Performed with `dbt` (BigQuery) as another Kestra flow [ke_gcp_dbt.yml](https://github.com/stefbp066/zoomcamp_capstone/blob/main/code/kestra/ke_gcp_dbt.yml). This flow is done after successfully completing the ingestion flow. The transformations included binning the wind direction as a new cardinal direction attribute and binning the cloud cover for all three subareas of the sky.
- **Deployment**: All components run in Docker containers on a GCP VM instance. The images are set to always restart (`restart: always`).

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

2. **Set up GCP credentials**

   - Go to your GCP Console.
   - Create or select a service account with the necessary permissions (e.g., BigQuery Admin, Storage Admin, Compute Admin).
   - Generate a key and download the JSON file.
   - Save it to your local machine and mount it in Docker using:

     ```yaml
     volumes:
       - ~/.google/credentials/google_credentials.json:/.google/credentials/google_credentials.json
     ```

3. **Configure your `.dbt/profiles.yml`**

   - Create a `.dbt` directory in your home folder if it doesn't exist:

     ```bash
     mkdir ~/.dbt
     ```

   - Inside, create a `profiles.yml` file with the following structure (adjust values as needed):

     ```yaml
     dbt_capstone:
       outputs:
         dev:
           type: bigquery
           method: service-account
           project: your-gcp-project-id
           dataset: your_dataset_name
           keyfile: /.google/credentials/google_credentials.json
           threads: 4
           timeout_seconds: 300
           location: your-region
       target: dev
     ```

4. **Start the pipeline locally (for testing)**

   From the project root, run:

   ```bash
   docker-compose up

5. **Deploy to GCP**

   - **Create a GCP VM instance**:
     - Choose a region and zone close to your data.
     - Use a custom image or manually install Docker and `git` after boot.
     - Clone this GitHub repository onto the VM.

   - **Configure Docker Compose to autostart services**:
     - Use the `restart: always` directive in your `docker-compose.yml` file to ensure containers start on boot.

   - **Set up Cloud Scheduler to start the VM daily**:
     - Go to **Cloud Scheduler** in the GCP console.
     - Create a job with a schedule like `55 23 * * *` (11:55 PM daily).
     - Use a Pub/Sub topic to trigger a Cloud Function or use direct HTTP if configured to start the VM.

   - **Set up a second Cloud Scheduler job to stop the VM**:
     - Use a schedule like `15 0 * * *` (12:15 AM daily).
     - Use the same method (HTTP or Pub/Sub) to stop the VM.

   - **Service account permissions**:
     - Make sure the Cloud Scheduler jobs run under a service account with the **Compute Instance Admin (v1)** role.
     - If using OAuth, ensure the scheduler uses the appropriate identity with correct permissions.

   - **Validate everything**:
     - Manually test booting the VM and verify containers are running with `docker ps`.
     - Check that Kestra and dbt flows run correctly on schedule.


