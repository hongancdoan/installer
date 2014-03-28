require "formula"

JAVA_MIN_VERSION = "1.7.0_51"

NO_JAVA_MESSAGE = """
ERROR: No Java found. 
"""

INCORRECT_JAVA_MESSAGE = """
ERROR: Incorrect Java version.
  The Magnet Mobile App builder requires Oracle Java #{JAVA_MIN_VERSION} or above.
"""

class JavaOnPathRequirement < Requirement
  fatal true

  def message
    NO_JAVA_MESSAGE
  end

  satisfy :build_env => false do
    which 'java'
  end
end

class JavaVersionRequirement < Requirement
  fatal true

  def message
    INCORRECT_JAVA_MESSAGE
  end

  satisfy :build_env => false do
    which 'java'
  end
end

class MavenDependency < Requirement
  fatal true
  default_formula 'maven'
 
  satisfy do
    which 'mvn'
  end
end

class MySqlDependency < Requirement
  fatal true
  default_formula 'mysql'

  satisfy do
   which 'mysql_config'
  end

end

#
# MAB formula (devel and stable)
#
class Mab < Formula
  homepage 'http://factory.magnet.com'
  url "https://github.com/etexier/installer/raw/master/magnet-tools-cli-installer-1.1.6.tgz"
  sha1 '80439b240de0c4073261bf0e6f1a70087bbe5a6e'

  devel do 
    version '1.1.7-SNAPSHOT'
    url "https://github.com/etexier/installer/raw/master/magnet-tools-cli-installer-1.1.7-SNAPSHOT.tgz"
    sha1 '7be914dda58f01505d24216ce13f0908738e3787'
  end

  option 'without-mysql', 'MySQL will not be installed'
  option 'without-maven' , 'Maven will not be installed'

  depends_on MavenDependency => :recommended
  depends_on MySqlDependency => :recommended
  depends_on JavaOnPathRequirement => :recommended
  depends_on JavaVersionRequirement => :recommended

  
  def install
    prefix.install Dir['*']
  end


  def caveats 

    caveats = ""
    
    java = which 'java'
    if not java
      caveats = caveats + NO_JAVA_MESSAGE
    else
      version = /[0-9]+\.[0-9]+\.[\.0-9_]+/.match(`#{java} -version 2>&1| grep "java version"`).to_s
      version_numbers = version.split('.')
      if (version_numbers[1].to_i < 7)
        caveats = caveats + INCORRECT_JAVA_MESSAGE
      elsif (version_numbers[2].split('_')[1].to_i < 51)
        wrong_java_patch_version = <<-EOS.undent
        WARNING: Incorrect Java patch version. 
          Current Java version is #{version}. 
          The Magnet Mobile App builder requires Oracle Java #{JAVA_MIN_VERSION} or above.
        EOS
        caveats = caveats + wrong_java_patch_version
      end
    end


    java_home = ENV['JAVA_HOME']
 
    if not java_home
      no_java_home = <<-EOS.undent
      WARNING: You have not set a JAVA_HOME environment variable. 
        It is recommended that you set it in order to ensure proper Maven behavior.
      EOS
      caveats = caveats + no_java_home
    else 
      java_on_java_home = Pathname.new("#{java_home}/bin/java").realpath.to_s
      java_path = Pathname.new("#{java}").realpath.to_s
      if java_on_java_home != java_path
        java_mismatch = <<-EOS.undent
        ERROR: Java executables mismatch.
          JAVA_HOME points to #{java_on_java_home} which is different from the 
          Java executable on the PATH #{java_path} 
        EOS
        caveats = caveats + java_mismatch
      end
    end

    mvn = which 'mvn'
    version =  /[0-9]+\.[0-9]+[\.0-9]*/.match(`#{mvn} -v | grep "Apache Maven"`).to_s
    version_numbers = version.split('.')
    if not (version_numbers[0].to_i >= 3 and version_numbers[1].to_i >=1)
      wrong_maven_version = <<-EOS.undent
      WARNING: The installed Maven version is #{version}. 
        It is recommended to use Apache Maven 3.1+.
        You can install the latest version of maven with 'brew install maven', 
        and remove the old version from your PATH.
        Finally, if you have set M2_HOME, ensure that it is pointing to the right maven installation.
      EOS
      caveats = caveats + wrong_maven_version
    end
     
    caveats

  end 

end