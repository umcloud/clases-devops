#!/bin/bash
#cd /opt/validate_email
source .venv/bin/activate
uwsgi --ini validate_email.ini
