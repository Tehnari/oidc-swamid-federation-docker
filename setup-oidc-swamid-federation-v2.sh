#!/usr/bin/env bash

#git clone https://github.com/rohe/oidc-swamid-federation.git
git clone https://github.com/sklemer1/oidc-swamid-federation.git
cd oidc-swamid-federation
python3 -mvenv venv
. venv/bin/activate
pip install git+https://github.com/openid/JWTConnect-Python-CryptoJWT.git@1eff9e5
pip install git+https://github.com/openid/JWTConnect-Python-OidcMsg.git@2c6bddc
pip install git+https://github.com/openid/JWTConnect-Python-OidcService.git@6bb00d6
pip install git+https://github.com/openid/JWTConnect-Python-OidcRP.git@85d09e4
pip install git+https://github.com/IdentityPython/oidcendpoint.git@37d107c
pip install git+https://github.com/rohe/oidc-op.git@71d293f
pip install git+https://github.com/IdentityPython/fedoidcmsg.git@d30107b
pip install git+https://github.com/IdentityPython/fedoidcservice.git@41f9fa6
pip install git+https://github.com/IdentityPython/fedoidcrp.git@700e443
pip install git+https://github.com/rohe/fed-oidc-endpoint.git@0c572b7
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
