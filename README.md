# Develop PubSub Streaming Data Projects

## Setup

Build the docker containers using the Dockerfiles provided in the subfolders of this repo.

    $ docker build -t beam .

## Run Docker

    $ docker container run -p 8888:8888 -name beam beam

## Run PubSub

### Start Server

    $ source env/bin/activate
    $ gcloud beta emulators pubsub start --project=myproject
    $ $(gcloud beta emulators pubsub env-init)

### Create Topic

    $ cd /opt/python-pubsub/samples/snippets    
    $ python /opt/python-pubsub/samples/snippetspublisher.py myproject create mytopic

### Create Subsrciption

    $ python subscriber.py myproject create mytopic mysubscription

### Publish Message

    $ python publisher.py myproject publish mytopic

### Read Message

    $ python subscriber.py myproject receive mysubscription

