#!/bin/bash

# Apply migrations
python django_web_app/manage.py makemigrations
python django_web_app/manage.py migrate

# Start the Django development server
python django_web_app/manage.py runserver 0.0.0.0:8000
