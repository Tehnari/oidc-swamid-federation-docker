#!/bin/bash

set -e
run_cmd="/app/setup-oidc-swamid-federation.sh"

>&2 echo "Executing cleaning and setup command"
exec $run_cmd