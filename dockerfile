#-------------------------------- Build stage -----------------------------------------
FROM python:3.9-slim as build

# Set environment variables
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1

# # Set the working directory in the build container
# WORKDIR /app

# Copy only the requirements file and install dependencies first to benefit from caching
COPY requirements.txt .
RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org -r requirements.txt

# --------------------------- Runtime stage ---------------------------------------------
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the application code from the build stage
COPY --from=build /app /app

# Run the application when the container starts
CMD ["python", "django_web_app/manage.py", "runserver", "0.0.0.0:8000"]

