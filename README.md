
# Introduction

The intention is the approach defined here will become a basic tool
for all developers to use. Some work must be done to achieve this but
we  hope to get there and I think that I see solutions to most
complaints.  It is based on ideas described
[here](https://metadatacenter.readthedocs.io/en/latest/install-overview/)
and on the previous version of the docker
["profile"](https://github.com/metadatacenter/cedar-docker-build.git). The
problem is that, especially where there is a single build script,
e.g. maven, that will initiate the build process, CEDAR is a very
complex system.  In order to get it to run, one must configure many
different pieces, many of which are used by CEDAR but have been
developed outside of the CEDAR poject.  This can take hours of tedious
work before a user is able to begin development.

The idea of using docker is to isolate the user from the vagarities of
these tools and to provide an automated install of these services

# Process steps

This will be expanded later and will include steps for deployment and
other development steps.

0. Choose a location for ${CEDAR_HOME} and ${CEDAR_SOURCE}.
1. Move this project to ${CEDAR_SOURCE}
0. copy and edit  the environment templates (set-env-internal.sh and
   set-env-external.sh) to ${CEDAR_HOME}/templates. It will also work
   if you copy them to ${CEDAR_HOME} but there are some new
   environment variables and the other scripts don't use the templates
   directory.
1. set CEDAR_HOME, CEDAR_SOURCE and run the  script
   cedar-initialize-env.sh.  The environment needs some more work.
   The relevant portion of my current .bashrc looks like this:
```
   export CEDAR_HOME=/var/CEDAR
   export CEDAR_SOURCE=${CEDAR_HOME}/src
   export PATH=$PATH:${CEDAR_SOURCE}/cedar-dev-root/bin:${CEDAR_SOURCE}/cedar-dev-root/bin/util
   . ${CEDAR_SOURCE}/cedar-dev-root/bin/initialize-environment.sh
```
5. reset-docker.sh - this step should be examined by Docker experts
   because it is destructive.  It approximates resetting docker to its
   original state and images (and containers) might be lost. 
6. initialize-cedar.sh - this step runs a ca (based on a self-signed
   certificate) and checks out the sources (into ${CEDAR_HOME}/src). 
7. startInfrastructure.sh - this step starts the infrastructure. 
8. Checkout the sources with git-clone-all.sh and make the files with
   mvn install on the cedar-project project
   (${CEDAR_SOURCE}/cedar-parent/cedar-project). The script
   create-jaxb-patch.sh is the replacement for the clever jaxb
   patch. The script start-dw-server.sh will start a given 
   service based on its first argument.


# Using eclipse for development

Do a mvn eclipse in the cedar-project project.

# Maintaining the scripts


