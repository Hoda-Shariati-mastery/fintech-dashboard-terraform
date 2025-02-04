#!/bin/bash

echo -e "$SERVICE_ACCOUNT_CREDENTIALS" > /workspaces/fintech-dashboard-terraform/credentials.json
chmod 600 /workspaces/fintech-dashboard-terraform/credentials.json
