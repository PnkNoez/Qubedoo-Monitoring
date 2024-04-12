FROM python:3-alpine
WORKDIR /code
COPY requirements.txt /code
RUN apk add --update py-pip openssl ca-certificates bash git sudo zip \
    && apk --update add --virtual build-dependencies libffi-dev openssl-dev build-base \
    && pip install --upgrade pip \
    && pip install -r requirements.txt \
    && apk --update add sshpass openssh-client \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/* 
COPY install.yml /code
COPY inventories /code/inventories
COPY files /code/files    
COPY vars /code/vars    
RUN mkdir ~/.ssh/ &&\
    chmod 700 ~/.ssh/ 

ARG GIT_VERSION_TAG=yolo
WORKDIR /usr/src/myapp
RUN echo $GIT_VERSION_TAG > GIT_VERSION_TAG.txt

CMD ansible-playbook --version 
