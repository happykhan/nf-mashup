# using ubuntu LTS version
FROM --platform=linux/x86_64 ubuntu:jammy
# avoid stuck build due to user prompt
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --no-install-recommends -y python3.11 python3.11-dev python3.11-venv python3-pip python3-wheel build-essential && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# install requirements
COPY requirements.txt .
RUN pip3 install -r requirements.txt
COPY *.py bin/
RUN chmod -R 765 bin/*.py
# make sure all messages always reach console
ENV PYTHONUNBUFFERED=1