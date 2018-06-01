#!/usr/bin/env bash

git clone https://github.com/rohe/oidc-swamid-federation.git
cd oidc-swamid-federation
python3.5 -mvenv venv
. venv/bin/activate
pip install --no-cache-dir oidcop oidcrp fedoidcendpoint fedoidcrp atomicwrites
./create_fo_bundle.py
sleep 1
cd MDSS
./create_sign_seq.py
sleep 1
cd ../OP
./enrollment_setup.py
sleep 1
cd ../RP
./enrollment_setup.py
sleep 2
cd ../MDSS
./enroll.py RP OP
sleep 1
cd ../RP
./rp.py -t -k conf&
sleep 1
cd ../OP
./server.py -t -k conf&
sleep 2
cd ../MDSS
./metadata_importer.py
sleep 2
./processor.py
sleep 2
./signing_service.py
sleep 2
./mdss.py -t config
