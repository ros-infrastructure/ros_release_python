FROM ubuntu:focal

ENV DEBIAN_FRONTEND=non-interactive
RUN apt-get update && apt-get install -qy \
    dput \
    fakeroot \
    debhelper \
    dh-python \
    apt-file \
    python3-setuptools \
    python3-all \
    python3-pip \
    openssh-client # scp for dput

RUN pip3 install -U stdeb
RUN pip3 install -U pip
RUN pip3 install -U setuptools
RUN pip3 install -U twine

RUN mkdir -p /ros_release_python/scripts
RUN mkdir -p /ros_release_python/resources
ADD scripts/ros_release_python /ros_release_python/scripts
ADD resources/dput.cf /ros_release_python/resources
ADD resources/include.cf /ros_release_python/resources

# Needed for dput
ENV USER=$USER

# Workaround for https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1003252
# As suggested https://stackoverflow.com/a/76474591/604099
ENV SETUPTOOLS_USE_DISTUTILS=stdlib