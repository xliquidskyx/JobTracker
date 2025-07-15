ARG PYTHON_VERSION=3.9.13
ARG PYTHON_BUILD_VERSION=$PYTHON_VERSION-slim-bullseye

FROM python:${PYTHON_BUILD_VERSION}

ENV PYTHONUNBUFFERED=1

WORKDIR /opt/jobtracker

COPY requirements.txt .

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends gcc && \
	pip install --upgrade pip && \
	pip install -r requirements.txt && \
	apt-get purge -y --auto-remove gcc && \
	rm -rf /var/lib/apt/lists/*

COPY . .

EXPOSE 8000

CMD ["python","manage.py","runserver"]