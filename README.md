Script to release Python packages used for ROS
==============================================

Setup
-----

The following dependencies need to be installed before being able to run the `ros_release_python` script:

 * Install the latest / a customized version of stdeb:
   * Python 2:
     * `sudo pip install stdeb`
   * Python 3:
     * `git clone https://github.com/dirk-thomas/stdeb`
     * `sudo python3.3 setup.py install`
 * Create a debhelper file for Python 3 distutils releases:
   * `cd /usr/share/perl5/Debian/Debhelper/Buildsystem && sudo cp python_distutils.pm python3_distutils.pm`
   * Modify the new file `/usr/share/perl5/Debian/Debhelper/Buildsystem/python3_distutils.pm` with the following changes (as described in http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=597105#35 ):

```
@@ -5,7 +5,7 @@
 #            © 2008-2009 Modestas Vainius
 # License: GPL-2+
 
-package Debian::Debhelper::Buildsystem::python_distutils;
+package Debian::Debhelper::Buildsystem::python3_distutils;
 
 use strict;
 use Cwd ();
@@ -117,14 +117,14 @@
 	# Then, run setup.py with each available python, to build
 	# extensions for each.
 
-	my $python_default = `pyversions -d`;
+	my $python_default = `py3versions -d`;
 	$python_default =~ s/^\s+//;
 	$python_default =~ s/\s+$//;
-	my @python_requested = split ' ', `pyversions -r 2>/dev/null`;
+	my @python_requested = split ' ', `py3versions -r 2>/dev/null`;
 	if (grep /^\Q$python_default\E/, @python_requested) {
 		@python_requested = (
 			grep(!/^\Q$python_default\E/, @python_requested),
-			"python",
+			"python3",
 		);
 	}
```

Prepare a Python package
------------------------

The Python package needs `stdeb2.cfg` and `stdeb3.cfg` files beside the `setup.py` file.

Release a Python package
------------------------

Invoke `scripts/ros_release_python --upload` in the root folder of the Python package.
