FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    linux-headers-virtual \
    make \
    gcc \
    git \
    curl \
    nano \
    libev-dev \
    libssl-dev \
    libc-dev \
    libffi-dev \
    libpcre3-dev \
    python3.9-full \
    python3.9-dev \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Create an isolated Python 3.9 environment.
# This prevents Ubuntu's system Python packages from being mixed with
# packages installed by pip.
RUN python3.9 -m venv /var/venv

# Use the virtual environment for all subsequent commands.
ENV PATH="/var/venv/bin:$PATH"

# Upgrade Python packaging tools inside the virtual environment.
RUN python -m pip install --upgrade pip wheel && \
    python -m pip install setuptools==59.6.0

COPY ./requirements.txt /tmp/requirements.txt

RUN python -m pip install -r /tmp/requirements.txt

COPY ./ /opt/webapp/

WORKDIR /opt/webapp

VOLUME /opt/webapp/collections

CMD ["uwsgi", "--ini", "uwsgi.ini"]