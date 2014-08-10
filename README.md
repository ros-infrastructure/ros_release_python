Script to release Python packages used for ROS
==============================================

Setup
-----

The following dependencies need to be installed before being able to run the `ros_release_python` script:

 * Install dput: `sudo apt-get install dput`
 * Install apt-file: `sudo apt-get install apt-file`
  * Then run `apt-file update`
 * Install `setuptools` for python3: `sudo apt-get install python3-setuptools`
 * Install `python-all`: `sudo apt-get install python-all`
 * Install the latest version of stdeb:
   * Python 2:
     * `sudo pip install stdeb`
       * This must be at least version 0.8.1. Older versions will not work.
   * Python 3:
     * `sudo pip3 install stdeb`
       * This must be at least version 0.8.1. Older versions will not work.

Prepare a Python package
------------------------

The Python package needs `stdeb2.cfg` and `stdeb3.cfg` files beside the `setup.py` file.

Release a Python package
------------------------

Invoke `scripts/ros_release_python --upload` in the root folder of the Python package.
