# Package management

## RPM (Redhat Package Manager)  

install telnet (package): ``rpm -i telnet.rpm``  
uninstall telnet (package): ``rpm -e telnet.rpm``  
query package: ``rpm -q telnet.rpm``  
query multiple: ``rpm -q telnet.rpm openssh-server ...``  
query all: ``rpm -qa``  
query specific: ``rpm -qa | grep packageName``  

Package managers does not install dependencies by themselves. For example, Anisble requires Python to be installed. This is why ``Yum`` exists....  
Yum is an abstraction layer on RPM, so it uses RPM underneath but with additions to install ALL required packages.  

![yum](imgs/yum.png)  

### Yum commands  

list yum repo: ``yum repolist``  
list files in: ``ls /etc/yum.repos.d/``  
see url where package is gotten from: ``cat etc/yum/examplePackage.repo``  
list package: ``yum list packageName``  
remove package: ``yum remove packageName`` 
list all available versions of package: ``yum --showduplicates list packageName``  
install package: ``yum install packageName`` (use flag -y to confirm)  
install specific version: ``yum install -y packageName-versionNumber``  
remove package: ``yum remove packageName``  

## Services

