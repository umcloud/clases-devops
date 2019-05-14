#!/usr/bin/env python
from mac_to_vendor import Mac
from flask import Flask, jsonify, Response, request
from flask_cors import CORS, cross_origin
from functools import wraps
import collections
import re
import json
import ConfigParser

#App
app = Flask(__name__)
CORS(app)


#General config
config = ConfigParser.ConfigParser()
config.read('mac_to_vendor.conf')


#Autentication
def check_auth(username, password):
    #echo "umcloud"|md5sum
    if username == "56ca8f8738ecc03cc4b2859db342e243":
        return 1
    else:
        return 0

def authenticate():
    message = {'message': "Authenticate."}
    resp = jsonify(message)

    resp.status_code = 401
    resp.headers['WWW-Authenticate'] = 'Basic realm="shaas-recovery"'

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

#API ENDPOINT

@app.route('/', methods=['GET'])
def get_root():
    options = {
        'status_code': 200
    }
    options['body'] = { 'mac': 'Hello! Authenticate && Give me a mac address' }
    return build_response_msg(options=options)


@app.route('/<mac>', methods=['GET'])
def get_mac(mac):
    options = {
        'status_code': 200
    }
    if mac:
        try:
            search = re.sub(":","-",mac)
            search = search[:8]
            search = search.upper()
            vendor = Mac()
            mac_vendor = vendor.vendor(search)
            if mac_vendor:
                options['body'] = { 'mac': mac, 'vendor': mac_vendor }
            else:
                options['status_code']= 404
        except:
                options['status_code']= 404
    return build_response_msg(options=options)

if __name__ == '__main__':
    app.run(debug=True)
