#!/usr/bin/env python
from flask import Flask, jsonify, Response, request
from flask_cors import CORS, cross_origin
from functools import wraps
from validate_email import validate_email
import re
import json
import base64
import datetime
import sys
import os

#App
app = Flask(__name__)
CORS(app)


#Autentication
def check_auth(username, password):
    if username == "56ca8f8738ecc03cc4b2859db342e243":
        return 1
    else:
        return 0

def authenticate():
    message = {'message': "Authenticate."}
    resp = jsonify(message)

    resp.status_code = 401
    resp.headers['WWW-Authenticate'] = 'Basic realm="shaas-jobs"'

    return resp

def requires_auth(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        auth = request.authorization
        if not auth:
            return authenticate()

        elif not check_auth(auth.username, auth.password):
            return authenticate()
        return f(*args, **kwargs)

    return decorated

#Helper functions
def build_response_msg(endpoint=None, options={}):
    if 'status_code' not in options:
        raise InternalServerErrorException()

    default_options = {
        'status_code': '',
        'headers': None,
        'body': None,
        'content_type': None
    }
    default_options.update(options)

    if default_options['body'] is not None:
        default_options['content_type'] = 'application/json'

    ret = {}
    if endpoint is not None:
        ret[endpoint] = default_options['body']
        ret = json.dumps(ret)
    else:
        ret = json.dumps(default_options['body'])

    response = Response(
        response=ret,
        status=default_options['status_code'],
        content_type=default_options['content_type']
    )

    if default_options['headers'] is not None:
        for key, val in default_options['headers'].items():
            response.headers[key] = val

    return response

def verify_email(email, mode=0):
    """
    Use 3rd party library to check whether e-mail is valid.
    Mode can be 0, 1, or 2
    0: Validate if e-mail is valid
    1: Validate if e-mail is valid and domain has SMTP Server
    2: Validate if e-mail is valid, domain has SMTP Server and emails actually exists
    """

    email = str(email)
    mode = int(mode)

    if mode not in [0, 1, 2]:
        mode = 2
    try:
        is_valid = False
        if mode == 0:
            is_valid = validate_email(email)
        elif mode == 1:
            is_valid = validate_email(email, check_mx=True, smtp_timeout=3)
        else:
            is_valid = validate_email(email, verify=True, smtp_timeout=3)
    except UnicodeEncodeError:
        is_valid = False
    except Exception:
        is_valid = True

    return True if is_valid else False


@app.route('/<email>/<mode>', methods=['GET'])
@requires_auth
def validate(email,mode):
    options = {
        'body': None,
        'status_code': 200
    }
    print(email, mode)
    options['body'] = verify_email(email, mode)
    return build_response_msg("validate", options = options)

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
