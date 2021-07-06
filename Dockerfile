FROM python:buster

# Install node prereqs, nodejs and yarn
# Ref: https://github.com/nikolaik/docker-python-nodejs/blob/master/Dockerfile
# Ref: https://deb.nodesource.com/setup_14.x
# Ref: https://yarnpkg.com/en/docs/install
RUN \
  echo "deb https://deb.nodesource.com/node_14.x buster main" > /etc/apt/sources.list.d/nodesource.list && \
  wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
  wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  apt-get update && \
  apt-get install -yqq nodejs yarn && \
  pip install -U pip && pip install pipenv && \
  npm i -g npm@^6 && \
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python && ln -s /root/.poetry/bin/poetry /usr/local/bin && \
  rm -rf /var/lib/apt/lists/*

# install git
RUN apt-get update && \
    apt-get install -yqq dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev && \
    rm -rf /var/lib/apt/lists/*

# install ajv
RUN npm i -g ajv-cli

# install gomplate
RUN curl -L https://github.com/hairyhenderson/gomplate/releases/download/v3.9.0/gomplate_linux-amd64-slim -o gomplate && \
    install gomplate /usr/local/bin    
