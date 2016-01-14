Ansible (Docker Container)
============

This container is to help with running ansible scripts in repeatable environment

You should run this container from working directory with ansible playbooks and pass your credentials to container, like this:

docker run -ti --rm -v $PWD:/work -v /home/user/.ssh/awsuser-key-pair-irln.pem:/work/.ssh/awsuser-key-pair-irln.pem -v /home/user/.boto:/root/.boto dansible /bin/bash

When container brings up bash prompt you can run ansible scripts.
