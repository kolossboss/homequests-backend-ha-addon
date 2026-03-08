ARG BUILD_FROM=docker.io/library/python:3.12-slim
FROM ${BUILD_FROM}

WORKDIR /opt/homequests

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends jq curl \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /opt/homequests/requirements.txt
RUN pip install --no-cache-dir -r /opt/homequests/requirements.txt

COPY app /opt/homequests/app
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 8000

CMD ["/run.sh"]
