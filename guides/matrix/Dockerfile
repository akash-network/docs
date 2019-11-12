FROM ovrclk/ubuntu-kb

RUN apt-get install -y build-essential python3-dev libffi-dev \
  python-pip python-setuptools sqlite3 \
  libssl-dev python-virtualenv libjpeg-dev libxslt1-dev

EXPOSE 8008/tcp 8009/tcp 8448/tcp

ADD install.sh /install.sh
RUN /install.sh

ADD run.sh /run.sh

WORKDIR /synapse

ENTRYPOINT ["/run.sh"]
