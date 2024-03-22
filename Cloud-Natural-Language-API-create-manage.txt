### Cloud Natural Language API ###

# Create an API key
    ##First, you will set an environment variable with your PROJECT_ID

        export GOOGLE_CLOUD_PROJECT=$(gcloud config get-value core/project)
    
    ##create a new service account to access the Natural Language AP

        gcloud iam service-accounts create my-natlang-sa \
        --display-name "my natural language service account"
    ##create credentials to log in as your new service account. Create these credentials and save it as a JSON file "~/key.json" by using the following command:

        gcloud iam service-accounts keys create ~/key.json \
        --iam-account my-natlang-sa@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com

    ##set the GOOGLE_APPLICATION_CREDENTIALS environment variable. The environment variable should be set to the full path of the credentials JSON file you created

        export GOOGLE_APPLICATION_CREDENTIALS="/home/USER/key.json"

# 