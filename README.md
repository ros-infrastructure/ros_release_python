Script to release Python packages used for ROS
==============================================

Setup
-----

The following dependencies need to be installed before being able to run the `ros_release_python` script:

 * Install dput:
   * `sudo apt-get install dput`
 * Install apt-file:
   * `sudo apt-get install apt-file`
   * and run:
   * `apt-file update`
 * Install setuptools:
   * `sudo apt-get install python-setuptools python3-setuptools`
 * Install Python "all":
   * `sudo apt-get install python-all python3-all`
 * Install PIP:
   * `sudo apt-get install python-pip python3-pip`
 * Install the latest version of stdeb (at least 0.8.2 - older versions willl not work):
   * `sudo pip install stdeb`
   * `sudo pip3 install stdeb`

Prepare a Python package
------------------------

The Python package needs a `stdeb.cfg` file beside the `setup.py` file.

Release a Python package
------------------------

Invoke `scripts/ros_release_python --upload` in the root folder of the Python package.

Release a Python package only into new suites
---------------------------------------------

Invoke `scripts/ros_release_python --includedeb --upload` in the root folder of the Python package.
