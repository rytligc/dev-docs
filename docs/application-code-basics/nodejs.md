# NodeJS

Node JS is a server side development framework that uses Java Script.  
It's free, open source and Cross Platform Compatible.  

## Installation

On CentOS (used in KodeKlouds lectures)  

```bash
# Get and install package
curl -sL https://rpm.nodesource.com/setup_13.x | bash -
yum install node

# List version
node -v

# Run file - add.js
node add.js


```

## NPM (Node Package Manager)

Commands

```bash
# version (could be different from nodeJS)
npm -v

# Node Search File to search for a package
npm search file

# install for project -- npm installs it in "node_modules" --> "file" in working directory
npm install file
.
└─node_modules
  └─file
    ├──LICENSE
    ├──README.md
    ├──package.json  # meta data for package, including name, author, git repo etc. 
    └──lib # code

# list all paths NPM is looking at
node -e "console.log(module.paths)"

# install globally available
npm install file -g

# built-in modules are located at
/usr/lib/node_modules/npm/node_modules/

# External modules (such as react)
/usr/lib/node_modules


```