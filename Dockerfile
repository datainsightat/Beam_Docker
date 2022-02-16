# https://www.udemy.com/course/apache-beam-a-hands-on-course-to-build-big-data-pipelines/learn/lecture/16134499
# https://cloud.google.com/python/docs/setup#linux
# https://cloud.google.com/sdk/docs/install
# https://cloud.google.com/pubsub/docs/emulator
# https://github.com/googleapis/google-cloud-python#google-cloud-python-client
# https://cloud.google.com/sdk/gcloud/reference/beta/emulators/datastore/start

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

ENV JUPYTERLAB_VERSION="3.2.1"

RUN apt-get update -y && \
    apt-get install -y git curl wget openssh-server openssh-client net-tools

##########
# PYTHON #
##########

RUN apt-get install -y python3 python3-dev python3-venv

RUN wget https://bootstrap.pypa.io/get-pip.py\
    && python3 get-pip.py

RUN python3 -m venv env

RUN /env/bin/pip install \
    google-cloud-storage \
    google-cloud-pubsub \
    apache-beam \
    apache-beam[gcp] \
    pyparsing==2.4.2 \
    wget==3.2 \
    jupyterlab==${JUPYTERLAB_VERSION}

RUN cd /opt \
    && git clone https://github.com/googleapis/python-pubsub.git \
    && /env/bin/pip install -r /opt/python-pubsub/samples/snippets/requirements.txt

###################
# Google Services #
###################

RUN apt-get install -y apt-transport-https ca-certificates gnupg \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list\
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get update && apt-get install -y \
        google-cloud-sdk \
        google-cloud-sdk-app-engine-python \
        google-cloud-sdk-app-engine-python-extras \
        google-cloud-sdk-pubsub-emulator \
        google-cloud-sdk-datastore-emulator

RUN mkdir /home/data
ADD data /home/data

ADD docker_start.sh /docker_start.sh

# #Run at container start
CMD ["bin/bash","docker_start.sh"]