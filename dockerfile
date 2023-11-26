#-------------------------------- Build stage -----------------------------------------
# Use a slim Python 3.9 image as the base image for the build stage
FROM python:3.9-slim AS build

# Copy only the requirements file and install dependencies first to benefit from caching
COPY requirements.txt .

# Install Python dependencies from the requirements file
RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org -r requirements.txt


# --------------------------- Runtime stage ---------------------------------------------
FROM python:3.9-slim

# Copy installed Python packages from the build stage to the runtime stage
COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

# Set the working directory inside the container to /django_app
WORKDIR /django_app

# Copy the application code from the local directory to /django_app in the container
COPY . /django_app/

# Run the Django application when the container starts
CMD ["python", "django_web_app/manage.py", "runserver", "0.0.0.0:8000"]


# # Use an official Python runtime as a parent image
# FROM python:3.9-slim


# # Set environment variables
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1


# # Set the working directory in the container
# WORKDIR /app


# # Copy the current directory contents into the container at /app
# COPY . /app


# # Install dependencies
# RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org -r requirements.txt
# # Run the application when the container starts
# CMD ["python", "django_web_app/manage.py", "runserver", "0.0.0.0:8000"]
