Magnet Mobile App Builder Installer
===================================

Version
-------
 - Stable: 2.3.0_M3

Requirements
------------
  - Java 1.7.0_45 or above
  - MySql 5.5 or above
  - Maven 3.1.1 or above

The installer will automatically install Maven, and MySql, but not Java. You must install Java 1.7 yourself first. 

It also checks that your environment variables as well as the versions of those executables are correct.

If you do not want to install some of the dependencies, do the following:
 - use _--without-mysql_ to skip MySql installation
 - use _--without-maven_ to skip Maven installation


MacOS
-----
Run:
```
brew install https://raw.githubusercontent.com/etexier/installer/master/mab.rb
```

If you don't have _brew_, go to: http://brew.sh/

You can verify your installation by running:
```
brew info mab
```
This will identify all potentials caveats on your system. 

Also, be sure the mysql is running, if you installed it with brew, you can verify whether it is running with:

```
mysql.server status
```
and start it with:
```
mysql.server start
```

To install future versions of mab, but keep the old version
```
brew unlink mab
brew install https://raw.githubusercontent.com/etexier/installer/master/mab.rb
```

Then you can switch version the following way (if you already have previous version):
```
brew switch mab <version>
```

To uninstall mab:
```
brew remove mab
```
Linux
-----
TBD

Windows
-------
TBD
