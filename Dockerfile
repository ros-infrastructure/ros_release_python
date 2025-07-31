FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=non-interactive
RUN apt-get update && apt-get install -qy \
    dput \
    fakeroot \
    debhelper \
    apt-file \
    python-setuptools \
    python3-setuptools \
    python-all \
    python3-all \
    python-pip \
    python3-pip \
    openssh-client # scp for dput

RUN pip install -U stdeb
RUN pip3 install -U stdeb
RUN pip3 install -U pip
RUN pip3 install -U wheel  # Older versions use an unsupported metadata format.
RUN pip3 install -U setuptools
RUN pip3 install -U twine

RUN mkdir -p /ros_release_python/scripts
RUN mkdir -p /ros_release_python/resources
ADD scripts/ros_release_python /ros_release_python/scripts
ADD resources/dput.cf /ros_release_python/resources
ADD resources/include.cf /ros_release_python/resources

# Needed for dput
ENV USER=$USER
