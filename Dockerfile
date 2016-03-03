FROM mongo:3.0

RUN apt-get update \
  && apt-get install --yes less procps wget build-essential python-dev python-pip \
  && apt-get clean

COPY client-install.sh /usr/local/bin/

RUN useradd --uid 501 --create-home --shell /bin/bash --groups staff mongoctl

WORKDIR /home/mongoctl

# Because the mongoctl installer works much to hard to install these files and fails!
COPY sample_conf/* .mongoctl/
RUN chown mongoctl:mongoctl -R .mongoctl

USER mongoctl

RUN pip install mongoctl

# Include a non-ssl shell as a fall back for commands
# install-mongodb installs that "latest-stable" according to the
# manually updated mongoctl github repository.
RUN mongoctl install-mongodb

# Include a version of 2.6 for older compatibility.
# Only full version labels are supported.
RUN mongoctl install-mongodb 2.6.11

# Make sure there is a version of 3.x
# This may or may not be the same as lastest-stable.
RUN mongoctl install-mongodb 3.0.9

COPY scripts /home/mongoctl/scripts/

ENTRYPOINT ["mongoctl"]
