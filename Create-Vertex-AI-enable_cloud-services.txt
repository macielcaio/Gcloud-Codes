### Vertex AI ###

#Enable Google Cloud services
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


#Create Vertex AI custom service account for Vertex Tensorboard integration
    ##Create custom service account:
        SERVICE_ACCOUNT_ID=vertex-custom-training-sa
            gcloud iam service-accounts create $SERVICE_ACCOUNT_ID  \
                --description="A custom service account for Vertex custom training with Tensorboard" \
                --display-name="Vertex AI Custom Training"

    ##Grant it access to Cloud Storage for writing and retrieving Tensorboard logs:
        PROJECT_ID=$(gcloud config get-value core/project)
        gcloud projects add-iam-policy-binding $PROJECT_ID \
            --member=serviceAccount:$SERVICE_ACCOUNT_ID@$PROJECT_ID.iam.gserviceaccount.com \
            --role="roles/storage.admin"

    ##Grant it access to your BigQuery data source to read data into your TensorFlow model:
        gcloud projects add-iam-policy-binding $PROJECT_ID \
            --member=serviceAccount:$SERVICE_ACCOUNT_ID@$PROJECT_ID.iam.gserviceaccount.com \
            --role="roles/bigquery.admin"

    ##Grant it access to Vertex AI for running model training, deployment, and explanation jobs:
        gcloud projects add-iam-policy-binding $PROJECT_ID \
            --member=serviceAccount:$SERVICE_ACCOUNT_ID@$PROJECT_ID.iam.gserviceaccount.com \
            --role="roles/aiplatform.user"

