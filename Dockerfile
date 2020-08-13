# For more information, please refer to https://aka.ms/vscode-docker-python
# FROM python:3.8-slim-buster

# EXPOSE 5000

# # Keeps Python from generating .pyc files in the container
# ENV PYTHONDONTWRITEBYTECODE 1

# # Turns off buffering for easier container logging
# ENV PYTHONUNBUFFERED 1

# ENV VAR1=10

# # Install pip requirements
# ADD requirements.txt .
# RUN python -m pip install -r requirements.txt

# WORKDIR /hello_app
# ADD . /hello_app

# # Switching to a non-root user, please refer to https://aka.ms/vscode-docker-python-user-rights
# RUN useradd appuser && chown -R appuser /app
# USER appuser

# # During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
# CMD ["gunicorn", "--bind", "0.0.0.0:5000", "hello_app.webapp:app"]


# Pull a pre-built alpine docker image with nginx and python3 installed
FROM tiangolo/uwsgi-nginx-flask:python3.6-alpine3.7

# Set the port on which the app runs; make both values the same.
#
# IMPORTANT: When deploying to Azure App Service, go to the App Service on the Azure 
# portal, navigate to the Applications Settings blade, and create a setting named
# WEBSITES_PORT with a value that matches the port here (the Azure default is 80).
# You can also create a setting through the App Service Extension in VS Code.
ENV LISTEN_PORT=5000
EXPOSE 5000

# Indicate where uwsgi.ini lives
ENV UWSGI_INI uwsgi.ini

# Tell nginx where static files live. Typically, developers place static files for
# multiple apps in a shared folder, but for the purposes here we can use the one
# app's folder. Note that when multiple apps share a folder, you should create subfolders
# with the same name as the app underneath "static" so there aren't any collisions
# when all those static files are collected together.
ENV STATIC_URL /hello_app/static

# Set the folder where uwsgi looks for the app
WORKDIR /hello_app

# Copy the app contents to the image
COPY . /hello_app

# If you have additional requirements beyond Flask (which is included in the
# base image), generate a requirements.txt file with pip freeze and uncomment
# the next three lines.
#COPY requirements.txt /
#RUN pip install --no-cache-dir -U pip
#RUN pip install --no-cache-dir -r /requirements.txt