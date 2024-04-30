### Activating more than one service via Cloud Shell ###

## Enabling APIs

    gcloud services enable \
    compute.googleapis.com \
    iam.googleapis.com \
    iamcredentials.googleapis.com \
    monitoring.googleapis.com \
    logging.googleapis.com \
    notebooks.googleapis.com \
    aiplatform.googleapis.com \
    bigquery.googleapis.com \
    artifactregistry.googleapis.com \
    cloudbuild.googleapis.com \
    container.googleapis.com

## Creating Service Account

    SERVICE_ACCOUNT_ID=vertex-custom-training-sa
    gcloud iam service-accounts create $SERVICE_ACCOUNT_ID  \
        --description="A custom service account for Vertex custom training with Tensorboard" \
        --display-name="Vertex AI Custom Training"


