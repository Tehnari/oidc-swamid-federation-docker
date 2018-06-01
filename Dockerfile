#
# This project should create a docker based on oidcfed-swamid-federation
# Please check your docker confirguration before run. 
# Ex. to run this project: 
#    docker run -t -d -p 8080:8080 -p 8100:8100 -p 8089:8089 tehnari/oidcfed-swamid-federation-docker:0.0.1 /bin/bash
#
FROM opensuse/leap
LABEL Author="Constantin Sclifos sclifcon@ase.md"
LABEL Name=tehnari/oidcfed-swamid-federation-docker Version=0.0.1
EXPOSE 8080 8100 8089

WORKDIR /app
ADD . /app

RUN zypper -v ref && zypper -n in -l vim  nano git curl wget python3 python3-pip screen net-tools&& \
    whereis pip3

RUN python3 -m pip install --upgrade pip

COPY ./cleanup-oidc-swamid-federation.sh /app/cleanup-oidc-swamid-federation.sh
COPY ./setup-oidc-swamid-federation.sh /app/setup-oidc-swamid-federation.sh
RUN chmod 777 /app/*.sh
RUN screen -A -m -d -S /bin/bash /app/setup-oidc-swamid-federation.sh &
RUN ss -tulpn | grep 80
