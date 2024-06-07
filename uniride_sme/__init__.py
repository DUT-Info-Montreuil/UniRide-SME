"""Initialisation of the api"""
from flask import Flask
from flask_caching import Cache
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from flask_mail import Mail
from flask_restful import Api
from flask_rq2 import RQ

from uniride_sme.config import Config

app = Flask(__name__)
app.config.from_object(Config)
cors = CORS(app, resources={r"*": {"origins": "https://localhost:4200"}}, supports_credentials=True)
api = Api(app)
mail = Mail(app)
jwt = JWTManager(app)
rq = RQ(app)
cache = Cache(app)
