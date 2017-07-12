#
# This Docker image encapsulates Maltrieve, a tool to retrieve malware
# directly from the source for security researchers.
# which was created by Kyle Maxwell (krmaxwell) and is
# available at https://github.com/krmaxwell/maltrieve.
#
# The file below is based on ideas from Spenser Reinhardt's Dockerfile
# (https://registry.hub.docker.com/u/sreinhardt/honeynet/dockerfile)
# and on instructions outlined by M. Fields (@shakey_1).
#
# To run this image after installing Docker, use a command like this:
#
# sudo docker run --rm -it technoskald/maltrieve

FROM python:2.7
MAINTAINER Michael Boman <michael@michaelboman.org>

RUN groupadd -r maltrieve && \
  useradd -r -g maltrieve -d /home/maltrieve -s /sbin/nologin -c "Maltrieve User" maltrieve

WORKDIR /home/maltrieve
ADD . /home/maltrieve
RUN pip install -r requirements.txt && \
  chown -R maltrieve:maltrieve /home/maltrieve

RUN mkdir /archive && \
  chown maltrieve:maltrieve /archive

USER maltrieve
ENV HOME /home/maltrieve
ENV USER maltrieve
WORKDIR /home/maltrieve
ENTRYPOINT ["maltrieve"]
CMD ["-d", "/archive/samples", "-l", "/archive/maltrieve.log"]
