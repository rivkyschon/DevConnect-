gcloud auth configure-docker me-west1-docker.pkg.de
gcloud auth login

docker tag rivkyschon/django_app:v0.0.0  me-west1-docker.pkg.dev/devconnect-final-project/rivkyschon-artifacts/django_app:test
docker push me-west1-docker.pkg.dev/devconnect-final-project/rivkyschon-artifacts/django_app:test
