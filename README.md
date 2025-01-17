Script to release Python packages used for ROS
==============================================

Setup
-----

The following dependencies need to be installed before being able to run the `ros_release_python` script:

 * Install dput:
   * `sudo apt-get install dput`
 * Install fakeroot:
   * `sudo apt-get install fakeroot`
 * Install debhelper:
   * `sudo apt-get install debhelper`
 * Install dh-python:
   * `sudo apt-get install dh-python`
 * Install apt-file:
   * `sudo apt-get install apt-file`
   * and run:
   * `sudo apt-file update`
 * Install setuptools:
   * `sudo apt-get install python3-setuptools`
 * Install Python "all":
   * `sudo apt-get install python3-all`
 * Install PIP:
   * `sudo apt-get install python3-pip`

 * Install up-to-date setuptools via PIP (if necessary):
   * `pip3 install --upgrade setuptools`
   * See https://packaging.python.org/guides/tool-recommendations/#publishing-platform-migration for more information why that is necessary.
 * Install `stdeb` (0.9.1 or higher) via PIP:
   * `sudo pip3 install [--upgrade] stdeb`
   * Do **not** use the Debian packages on Wily and newer.
     They will embed a newer Python dependency into the control file (2.7.5, 3.3.2) which breaks the package on older distributions like *Precise*.
 * Install `twine` via PIP:
   * `sudo pip3 install [--upgrade] twine`


Prepare a Python package
------------------------

The Python package needs a `stdeb.cfg` file beside the `setup.py` file.

Release a Python package
------------------------

Invoke `scripts/ros_release_python` in the root folder of the Python package to ensure that the packages can be built.
If this succeeds invoke the same command with the `--upload` argument to actually push the packages to the servers.

Release a Python package only into new suites
---------------------------------------------

Invoke `scripts/ros_release_python --include --upload` in the root folder of the Python package.

Releasing only python3 packages into new suites
-----------------------------------------------

As of stdeb 0.9.0 a `Suite3` option is allowed in stdeb.cfg when building python2 and python3 packages separately as these scripts do.
You can use this feature to prevent the release of python2 packages into new distributions where we do not support python2 (e.g. Ubuntu 20.04 Focal).

Releasing Python 2 packages targeting Ubuntu pre-Focal from Focal
-----------------------------------------------------------------

As of stdeb 0.9.1 a `Python2-Depends-Name` option is allowed in stdeb.cfg to override the Python 2 package name.
You can use this feature to force the Python 2 package name to be `python` rather than `python2` as it is on Ubuntu Focal.

You will also need to install the python 2 equivalents of the above packages on your system.

Sync into building / testing / main repos
-----------------------------------------

This tool only uploads the generated Debian packages into the `bootstrap` repository.
To make the packages available in the building / testing / main repos the Jenkins job to "import upstream" must be run.


Quick usage via rocker
----------------------

If you have your ssh and pypi credentials available in your home directory.

* `docker build -t rrp .`
* `rocker --home --user rrp`
* `cd <PATH TO PACKAGE>`
* `/ros_release_python/scripts/ros_release_python <ARGS>`


On one of my machines I had to increase ulimit to help fakeroot https://github.com/moby/moby/issues/27195 as of rocker 0.2.18 you can add `--ulimit nofile=1024` to work around that. 