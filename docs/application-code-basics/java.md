# Java Basics

## Setting up Java
```java
// check version
java -version

// docs
javadoc

// build app
javac

// debug app
javadb

// install java 13 inside of /opt directory
sudo curl "https://download.java.net/java/GA/jdk13.0.2/d4173c853231432d94f001e99d882ca7/8/GPL/openjdk-13.0.2_linux-x64_bin.tar.gz --output /opt/openjdk-13.0.2_linux-x64_bin.tar.gz"

// To uncompress run 
sudo tar -xf /opt/openjdk-13.0.2_linux-x64_bin.tar.gz -C /opt/

// To verify run 
/opt/jdk-13.0.2/bin/java -version

// Set Java to Path
export PATH=$PATH:/opt/jdk-13.0.2/bin
```

# Maybe look further into Java at some point...