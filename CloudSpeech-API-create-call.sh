######

To create an API key, click Navigation menu > APIs & services > Credentials.

Then click Create credentials.

In the drop down menu, select API key.

Copy the key you just generated and click Close.

######

#On VM instances, click on SSH to access VM
    
    ##enter in the following, replacing <YOUR_API_KEY> with the API key you copied from previously generated

            export API_KEY=<YOUR_API_KEY>

#Create your Speech-to-Text API request

    ##Create request.json in the SSH command line. You'll use this to build your request to the Speech-to-Text API:
    
        touch request.json

    ##open the request json

        nano request.json

    ##add the infos configs on request JSON
        ##then click CTRLx + y + ENTER


#Call the Speech-to-Text API
    
    ##Pass your request body, along with the API key environment variable, 
    to the Speech-to-Text API with the following curl command (all in one single command line)

        curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json \
        "https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}"

    ##Run the following command to save the response in a result.json file

        curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json \
        "https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" > result.json