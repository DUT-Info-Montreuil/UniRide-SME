FROM python:3.10

WORKDIR /usr/src/app

ENV SECRET_KEY=zeGd2SfM9Az58NqFCD9qdzQ9J82SwHdvFmqB6tPAqTz4astsdc
ENV SECURITY_PASSWORD_SALT='$2b$12$.e1z9Oj7OFux0.DT.VnBm.'

# Mail config
ENV MAIL_SERVER=smtp.gmail.com
ENV MAIL_PORT=465
ENV MAIL_USE_TLS=False
ENV MAIL_USE_SSL=True
ENV MAIL_DEBUG=False
ENV MAIL_USERNAME=uniride.uniride@gmail.com
ENV MAIL_PASSWORD='tweh usfx fhcr acsq'

ENV MAIL_EXPIRATION=600

ENV UNIVERSITY_EMAIL_DOMAIN=iut.univ-paris8.fr

ENV MAX_CONTENT_LENGTH=5000000
ENV PFP_UPLOAD_FOLDER=/usr/src/app/documents/pft
ENV LICENSE_UPLOAD_FOLDER=/usr/src/app/documents/license
ENV ID_CARD_UPLOAD_FOLDER=/usr/src/app/documents/id_card
ENV SCHOOL_CERTIFICATE_UPLOAD_FOLDER=/usr/src/app/documents/school_certificate
ENV INSURANCE_UPLOAD_FOLDER=/usr/src/app/documents/insurance

# JWT config
ENV JWT_SALT='$2b$12$CrXbxXB4ZQhZSxmI5/1Kxu'
ENV JWT_SECRET_KEY=NTtR94WqS8avr3Q7raTDS6D69KCJKpR2geViUxnGSQS3QQS2M5vHNKsV6XV2KWs2
ENV JWT_TOKEN_LOCATION=["cookies"]
ENV JWT_COOKIE_SECURE=True
ENV JWT_COOKIE_CSRF_PROTECT=False
ENV JWT_ACCESS_TOKEN_EXPIRES=3600
ENV JWT_ACCESS_TOKEN_REFRESH=600
ENV JWT_REFRESH_TOKEN_EXPIRES=30
ENV JWT_COOKIE_SAMESITE=None

# RQ config
ENV CACHE_TYPE=RedisCache
ENV RQ_REDIS_URL=redis://uniride_redis:6379/0

# Cache config
ENV CACHE_REDIS_HOST=uniride_redis
ENV CACHE_REDIS_PORT=6379
ENV CACHE_REDIS_PASSWORD=''
ENV CACHE_REDIS_DB=1

ENV FRONT_END_URL=https://localhost:4200

# DB config
ENV DB_HOST=uniride_db
ENV DB_NAME=uniride
ENV DB_USER=rayan
ENV DB_PWD=LfpIhadzadza1144sg1A79TLNAxX9k
ENV DB_PORT=5432

ENV TESTING=False
ENV DEBUG=False

# University address
ENV UNIVERSITY_STREET_NUMBER=140
ENV UNIVERSITY_STREET_NAME='Rue de la Nouvelle France'
ENV UNIVERSITY_CITY=Montreuil
ENV UNIVERSITY_POSTAL_CODE=93100

# Api key for google maps
ENV GOOGLE_API_KEY=AIzaSyBMreuA5LC2BJ2f-HFPPdzadzahYISSIu0mSS2Gs
ENV ROUTE_CHECKER=google

ENV RATE_PER_KM=0.13
ENV COST_PER_KM=0.10
ENV BASE_RATE=1.50

ENV ACCEPT_TIME_DIFFERENCE_MINUTES=10

# Flask configuration
ENV FLASK_DEBUG=false
ENV FLASK_HOST=0.0.0.0
ENV FLASK_PORT=5050

# Certs
ENV CERTIFICATE_CRT_FOLDER=certs/flask-selfsigned.crt
ENV CERTIFICATE_KEY_FOLDER=certs/flask-selfsigned.key

# Copy pyproject.toml first to avoid reinstalling dependencies when code changes
COPY pyproject.toml .

COPY . .

RUN pip install -e .

RUN apt-get update \
    && apt-get install curl
RUN mkdir /usr/src/app/uniride_sme/certs

RUN curl \
    -o /usr/src/app/uniride_sme/certs/flask-selfsigned.crt \
    'https://pastebin.com/raw/853gU6nq'

RUN curl \
    -o /usr/src/app/uniride_sme/certs/flask-selfsigned.key \
    'https://pastebin.com/raw/FS2Dv8hp'

# Set timezone to Paris, France
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 5050

ENTRYPOINT [ "python3" ]

CMD ["uniride_sme/rest_api.py"]