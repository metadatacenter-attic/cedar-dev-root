
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

## Setting up the environment

0. Choose a location for <i>${CEDAR_HOME}</i> and <i>${CEDAR_SOURCE}</i> and set
   these variables.  I put the settings for these variables in my
   <b>~/.bashrc</b> which I show below.
1. Move this project to <i>${CEDAR_SOURCE}</i>
0. If you want to make any changes to the environment templates, put
   the changes in <i>${CEDAR_HOME}/templates</i>. In my case, for example, I
   have a <b>set-env-external</b> in <i>${CEDAR_HOME}/templates</i> which sets the
   <i>CEDAR_BIOPORTAL_API_KEY</i> variable. Source the <b>initialize-environment</b>
   script to set this environment.  I load this environment in my
   <b>~/.bashrc</b> as shown below.

I use the .bashrc to load the environment.   The relevant portion of my current .bashrc looks like this:
```
   export CEDAR_HOME=/var/CEDAR
   export CEDAR_SOURCE=${CEDAR_HOME}/src
   export PATH=$PATH:${CEDAR_SOURCE}/cedar-dev-root/bin:${CEDAR_SOURCE}/cedar-dev-root/bin/util
   . ${CEDAR_SOURCE}/cedar-dev-root/bin/initialize-environment.sh
```

## Resetting docker

Optionally at this point you may want to reset some portion of
   docker.  I have set up three scripts supporting this and more may
   come soon.  These scripts may generate some errors when they try to
   delete things that don't exist or are a permanent part of docker.

1. <b>reset-docker</b> will, as close as I know how at this point,
   will reset the entire docker state.  It should not be used by
   people who are using docker for more than one project, because it
   is destructive.  It approximates resetting docker to its
   original state and images (and containers) might be
   lost.
3. <b>reset-cedar</b> resets all the named components of cedar.  If
   you are running a custom ca, like one based on lets encrypt or one
   based on a certificate authority, you
   may have to re-run it after this step to repopulate volumes such as
   <i>certs_and_keys_keycloak</i>. This script and its cousin
   <b>reset-ca</b> don't change the ca certificate so the firefox step
   does not need to be repeated.  Also these two scripts don't remove
   anonymous volumes (probably databases) which is probably
   desireable. <b>stopall</b> is currently
   commented out in this script only because it doesn't yet work.
2. <b>reset-ca</b> is a more targetted version that will only
   delete named objects that are known to be used by the ca.  It is
   still destructive but it is much safer then <b>reset-docker</b>.
   Reset-ca is designed to keep the same certificate authority key and
   certificate so that, for example, you do not have to repeat the
   installing the certificate into firefox step.

## Initializing the CA

<b>initialize-cedar</b> - this step runs a ca (based on a self-signed
   certificate) and fills some volumes used by other components, such
   as certs_and_keys_nginx.  For the first run of this command, go
   start the water boiling, as it takes a bit to install the
   components needed by the ca. There will be other variations of this
   script as we deploy different cas.  An easy case that is already
   accomodated - modulo security issues - is the case that someone
   gives you a signing certificate to use.  A more complicated case
   will be lets encrypt which we will probably do soon.  It seems
   likely that the more complicated cases will not use the cedar_ca volume.

## Starting the Infrastructure

<b>startInfrastructure</b> - this step starts the
   infrastructure. When doing this the first time, go
   drink a coffee, this takes a bit.  Especially since keycloak has a
   kludged hack (a wired in sleep which I will fix) to coordinate with <i>MySQL</i>.

## Starting Development

1. Checkout the sources with cedar-git-clone and do a mvn install in
   cedar-parent and cedar-project.  If you have jaxb troubles with cedar-cadsr-tool then probably you have
   not run create-jaxb2-workaround which is a patch for a jaxb bug.
2. startall starts all the microservices.  It is not a deployment script yet.


### Using eclipse for development

Do a mvn eclipse in the cedar-project project.

# Maintaining the scripts

## Anatomy of my Dockerfiles

1. <b>install.sh</b>
2. <b>configure.sh</b>
3. <b>docker-entrypoint.sh</b>
      * <b>configure-volumes.sh</b>
      * <b>docker-entrypoint content</b>

## dkill

## Environment variables

Caution: typos are easily missed and are fatal!

## Break points

## Debugging networking

If one of the network clients is a java process then you can use the
<code>
    -Djavax.net.debug=ALL
</code>
option to debug the network connection. This was very handy when I had
trouble with the system-reset admin call.  My first problem had to do
with SSL - I did not yet understand the difference between a ketstore
and a truststore.  When I first started debugging it, I thought that
the error message meant that the admin client was having trouble
validating a keycloak certificate.  This puzzled me because - not
understanding the difference betweeen a keystore and a truststore - I had
spent some time setting up the keycloak keystore to ensure that it was
not thrown away.  My unjustified worry was that it was tring to
validate a localhost certificate that will (and should) always fail.

The above command showed me that the certificate in question was the
nginx certificate.  It also showed me a list of the trusted ca
certificates which led me directly to an understanding of keystores
vs. trust stores.  A trust store is a list of those certificates
needed to validate external sites.  A keystore is a list of those
keys and certificates that are needed to identify yourself.

So I was still in trouble.