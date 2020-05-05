FROM circleci/python

USER root

RUN apt-get update -y && \
    apt-get install wget -y && \
    apt-get install postgresql-client -y

# Install aws cli + bump2version
RUN pip install awscli bump2version --upgrade --user
ENV PATH=~/.local/bin:$PATH

# Install terraform
RUN wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip     
RUN unzip terraform_0.12.24_linux_amd64.zip
RUN mv terraform /usr/local/bin/
