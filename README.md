
# Introduction

The intention is the approach defined here will become a basic tool
for all developers to use. Some work must be done to achieve this but
we  hope to get there and I think that I see solutions to most
complaints.  It is based on ideas described
[here]{https://metadatacenter.readthedocs.io/en/latest/install-overview/}
and on the previous version of the docker
["profile"]{https://github.com/metadatacenter/cedar-docker-build.git}. The
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

1. reset-docker.sh - this step should be examined by Docker experts
because it is destructive.  It approximates resetting docker to its
original state and images (and containers) might be lost.
2. initialize-cedar.sh - this step runs a ca (based on a self-signed
certificate) and checks out the sources (into ${CEDAR_HOME}/src).
3. startInfrastructure.sh - this step starts the infrastructure.
4. (for now) start development.
