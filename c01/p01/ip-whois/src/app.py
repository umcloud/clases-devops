#!/usr/bin/env python
from flask import Flask, jsonify, Response, request
from flask_cors import CORS, cross_origin
from functools import wraps
import collections
import re
import json
import ConfigParser
from ipwhois import IPWhois

#App
app = Flask(__name__)
CORS(app)


#General config
config = ConfigParser.ConfigParser()
config.read('ip_whois.conf')


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

def whois(input_ip,depth=1):
    try:
        result = IPWhois(input_ip)
        ret = result.lookup_rdap(depth=depth)
        return ret
    except:
        return False

#API ENDPOINTS

@app.route('/<ip_address>', methods=['GET'])
@requires_auth
def get_whois(ip_address):
    options = {
        'status_code': 200
    }
    
    who = whois(ip_address)
    if who:
        options['body'] = { 'whois': who }
    else:
        options['status_code']= 404

    return build_response_msg(options=options)

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)

