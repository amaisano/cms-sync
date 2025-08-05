#!/bin/bash
# See https://pantheon.io/docs/terminus/commands for reference
# Requires a machine token generated from Pantheon and passed as an envar
# - See https://pantheon.io/docs/machine-tokens

# bail on errors
set -e

# login to Terminus
echo -e "\nLogging into Terminus..."
terminus auth:login --machine-token=${PANTHEON_MACHINE_TOKEN}

# backup test prior to sync
echo -e "\nBacking up test site..."
terminus backup:create mbta.test

# clone database and files to test
echo -e "\nCloning live site to test..."
terminus env:clone-content -v -y --cc mbta.live test

# dev does not need an on-demand backup,
# plus it has daily, scheduled backups

# clone database and files to dev
echo -e "\nCloning test site to dev..."
terminus env:clone-content -v -y --cc mbta.test dev

# backup sandbox DB prior to sync
echo -e "\nBacking up sandbox database..."
terminus backup:create --element=db mbta.sandbox

# clone database and files to sandbox
echo -e "\nCloning dev site to sandbox..."
terminus env:clone-content -v -y --cc mbta.dev sandbox

echo -e "\nPantheon test, dev, and sandbox environments have been successfully synced with live."
