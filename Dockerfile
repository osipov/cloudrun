FROM osipov/terraform:latest
RUN apt-get update && apt-get install -y \
	curl \
	docker.io
ENV CLOUDSDK_INSTALL_DIR /opt/gcloud/
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH="/opt/gcloud/google-cloud-sdk/bin/:${PATH}"
WORKDIR /work
