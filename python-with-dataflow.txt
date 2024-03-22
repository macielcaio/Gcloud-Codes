### Dataflow: Qwik Start - Python ###

#Install the Apache Beam SDK for Python

    ##To ensure that you use a supported Python version, begin by running the Python3.9 Docker Image:

     docker run -it -e DEVSHELL_PROJECT_ID=$DEVSHELL_PROJECT_ID python:3.9 /bin/bash

    ##After the container is running, install the latest version of the Apache Beam SDK for Python by running the following command from a virtual environment:
    
     pip install 'apache-beam[gcp]'==2.42.0

    ##Run the wordcount.py example locally by running the following command:
    
     python -m apache_beam.examples.wordcount --output OUTPUT_FILE

#Run an example Dataflow pipeline remotely

    ##Set the BUCKET environment variable to the bucket you created earlier:
        BUCKET=gs://<bucket name provided earlier>

    ##Now you'll run the wordcount.py example remotely:
        python -m apache_beam.examples.wordcount --project $DEVSHELL_PROJECT_ID \
        --runner DataflowRunner \
        --staging_location $BUCKET/staging \
        --temp_location $BUCKET/temp \
        --output $BUCKET/results/output \
        --region "filled in at lab start"

