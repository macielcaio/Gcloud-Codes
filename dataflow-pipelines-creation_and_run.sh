#CRIA BIG QUERY DATASET E TABELA COM CLOUD SHELL (reate a BigQuery dataset, BigQuery table, and Cloud Storage bucket using Cloud Shell)

    ##CRIA DATASET CHAMADO 'TAXIRIDES'
        bq mk taxirides

    ##INSTANCIA BIG QUERY TABLE
        bq mk \
        --time_partitioning_field timestamp \
        --schema ride_id:string,point_idx:integer,latitude:float,longitude:float,\
        timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,\
        passenger_count:integer -t taxirides.realtime

#CRIA CLOUD STORAGE BUCKET USANDO CLOUD SHELL

    export BUCKET_NAME="Bucket Name"
    gsutil mb gs://$BUCKET_NAME/


#RODA PIPELINE

    ##FAZ DEPLOY DO TEMPLATE
        gcloud dataflow jobs run iotflow \
        --gcs-location gs://dataflow-templates-"Region"/latest/PubSub_to_BigQuery \
        --region "Region" \
        --worker-machine-type e2-medium \
        --staging-location gs://"Bucket Name"/temp \
        --parameters inputTopic=projects/pubsub-public-data/topics/taxirides-realtime,outputTableSpec="Table Name":taxirides.realtime

