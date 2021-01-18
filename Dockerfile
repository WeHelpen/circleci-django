FROM ubuntu:20.04

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

COPY ubuntu-20.04LTS_build.txt /srv

RUN set -ex; \
    apt-get -q update; \
    apt-get -q -y install --no-install-recommends \
        python3-venv python3-pip; \
    grep -v '^$\|^\s*\#' /srv/ubuntu-20.04LTS_build.txt | xargs apt-get -q -y --no-install-recommends install; \
    rm -rf /var/cache/debconf/*-old; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /var/log/*.log; \
    rm -rf /var/log/apt/*;

RUN set -ex; \
    python3 -m venv /srv/venv/; \
    /srv/venv/bin/pip --no-cache-dir --disable-pip-version-check install --upgrade pip wheel setuptools tox; \
    rm -rf /srv/venv/share/python-wheels;

ENV PATH=/srv/venv/bin:$PATH
WORKDIR /srv/app
CMD /srv/venv/bin/tox
