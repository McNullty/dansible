FROM ubuntu:latest
MAINTAINER mladen.cikara@gmail.com

ENV ANSIBLE_VERSION devel
ENV ANSIBLE_HOSTS /etc/ansible/ec2.py
ENV EC2_INI_PATH /etc/ansible/ec2.ini

RUN apt-get update && \
    apt-get install -y python-yaml \
       python-jinja2 \
       python-httplib2 \
       python-keyczar \
       python-paramiko \
       python-setuptools \
       python-pkg-resources \
       git \
       python-pip \
       sshpass \
       openssh-client

RUN mkdir /etc/ansible/ && \
    cd /etc/ansible/ && \
    wget https://raw.githubusercontent.com/ansible/ansible/devel/plugins/inventory/ec2.ini && \
    wget https://raw.githubusercontent.com/ansible/ansible/devel/plugins/inventory/ec2.py && \
    chmod +x /etc/ansible/ec2.py


RUN mkdir /opt/ansible/ && \
    git clone -b "$ANSIBLE_VERSION" http://github.com/ansible/ansible.git /opt/ansible/ansible

WORKDIR /opt/ansible/ansible

RUN git submodule update --init

RUN sh  /opt/ansible/ansible/hacking/env-setup

ENV PATH /opt/ansible/ansible/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PYTHONPATH /opt/ansible/ansible/lib
ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library
ENV MANPATH /opt/ansible/docs/man:

RUN pip install boto

COPY rc.local /etc/

RUN mkdir /ansible
WORKDIR /ansible

CMD ["/bin/bash"]
