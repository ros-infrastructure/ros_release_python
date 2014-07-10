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
 * Install the latest / a customized version of stdeb:
   * Python 2:
     * `sudo pip install stdeb`
       * This must be from pip. The 0.6.0 version from debian will not work.
   * Python 3:
     * `git clone https://github.com/dirk-thomas/stdeb`
       * On a newly installed Trusty machine I needed the `distutils-based-on-python-version-based-on-0.7.1` of the stdeb fork
     * `sudo python3.3 setup.py install`
       * On a newly installed Trusty machine I needed the `current` branch of this repo
 * Create a debhelper file for Python 3 distutils releases:
   * `cd /usr/share/perl5/Debian/Debhelper/Buildsystem && sudo cp python_distutils.pm python3_distutils.pm`
   * Modify the new file `/usr/share/perl5/Debian/Debhelper/Buildsystem/python3_distutils.pm` with the following changes (as described in http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=597105#35 ): 

On Precise:
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

On Saucy / Trusty:
```
/usr/share/perl5/Debian/Debhelper/Buildsystem$ diff -u python_distutils.pm python3_distutils.pm
--- python_distutils.pm	2013-07-01 03:28:26.000000000 -0700
+++ python3_distutils.pm	2014-02-17 20:47:57.186609276 -0800
@@ -5,7 +5,7 @@
 #            © 2008-2009 Modestas Vainius
 # License: GPL-2+
 
-package Debian::Debhelper::Buildsystem::python_distutils;
+package Debian::Debhelper::Buildsystem::python3_distutils;
 
 use strict;
 use Cwd ();
@@ -117,23 +117,23 @@
 	# Then, run setup.py with each available python, to build
 	# extensions for each.
 
-	my $python_default = `pyversions -d`;
+	my $python_default = `py3versions -d`;
 	if ($? == -1) {
-		error("failed to run pyversions")
+		error("failed to run py3versions")
 	}
 	my $ecode = $? >> 8;
 	if ($ecode != 0) {
-		error("pyversions -d failed [$ecode]")
+		error("py3versions -d failed [$ecode]")
 	}
 	$python_default =~ s/^\s+//;
 	$python_default =~ s/\s+$//;
-	my @python_requested = split ' ', `pyversions -r`;
+	my @python_requested = split ' ', `py3versions -r`;
 	if ($? == -1) {
-		error("failed to run pyversions")
+		error("failed to run py3versions")
 	}
 	$ecode = $? >> 8;
 	if ($ecode != 0) {
-		error("pyversions -r failed [$ecode]")
+		error("py3versions -r failed [$ecode]")
 	}
 	if (grep /^\Q$python_default\E/, @python_requested) {
 		@python_requested = (

```

Prepare a Python package
------------------------

The Python package needs `stdeb2.cfg` and `stdeb3.cfg` files beside the `setup.py` file.

Release a Python package
------------------------

Invoke `scripts/ros_release_python --upload` in the root folder of the Python package.
