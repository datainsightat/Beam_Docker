# Develop PubSub Streaming Data Projects

## Setup

Build the docker containers using the Dockerfiles provided in the subfolders of this repo.

    $ docker build -t pubsub_beam .

## Run Docker

    $ docker container run -it --name pubsub pubsub_beam bash

## Run PubSub

### Start Server

    $ source env/bin/activate
    $ gcloud beta emulators pubsub start --project=myproject
    $ $(gcloud beta emulators pubsub env-init)

### Create Topic

    $ python publisher.py myproject create mytopic

### Create Subsrciption

    $ python subscriber.py myproject create mytopic mysubscription

### Publish Message

    $ python publisher.py myproject publish mytopic

### Read Message

    $ python subscriber.py myproject receive mysubscription

