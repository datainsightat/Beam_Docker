#!/bin/sh

source env/bin/activate

#RUN gcloud init

#gcloud beta emulators pubsub start --project=mypubsubproject

#Jupyter
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --notebook-dir=/home/data --NotebookApp.token=

#Keep Container alive Test
#tail -f /dev/null