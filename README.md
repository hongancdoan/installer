
Magnet Mobile App Builder Installer
===================================

Version
-------
Stable: 1.1.6
Development: 1.1.7-SNAPSHOT

Requirements
------------
  - Java 1.7.0_51 or above
  - MySql 5.5 or above
  - Maven 3.1.1 or above

The installer will automatically install Maven, and MySql, but not Java. You must install Java 1.7 yourself first. 

It also checks that your environment variables as well as the versions of those executables are correct.

MacOS
-----
Run:
```
brew install https://raw.githubusercontent.com/etexier/installer/master/mab.rb
```
If you don't _brew_, go to: http://brew.sh/

You can verify your installation by running:
```
brew info mab
```
It will identify all potentials caveats on your system.


To install future versions of mab, but keep the old version
```
brew unlink mab
brew install https://raw.githubusercontent.com/etexier/installer/master/mab.rb
```

Then you can switch version the following way:
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
