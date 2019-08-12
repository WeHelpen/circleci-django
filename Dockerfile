FROM ubuntu:bionic

RUN mkdir -p /srv/requirements

COPY ubuntu-18.04LTS_build.txt /srv/requirements

RUN apt-get -q update && \
    apt-get -q -y install --no-install-recommends \
        python3-venv python3-pip && \
    grep -v '^$\|^\s*\#' /srv/requirements/ubuntu-18.04LTS_build.txt | xargs apt-get -q -y install

RUN virtualenv /srv/venv/
RUN /srv/venv/bin/pip install --upgrade pip wheel setuptools tox

ENV LANG C.UTF-8

CMD cd /srv/app && /srv/venv/bin/tox
