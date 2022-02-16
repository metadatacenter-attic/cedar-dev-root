#!/bin/bash

mkdir --parents ${CEDAR_SOURCE}
cd ${CEDAR_SOURCE}

if [ -e cedar-parent ]
then
    echo Exiting! Sources already checked out.
    exit 00
fi

#
# Must already have cedar-dev-root to run this script
#

git clone https://github.com/metadatacenter/cedar-keycloak-event-listener
git clone https://github.com/metadatacenter/cedar-parent
cd cedar-parent


CEDAR_REPOS=(
  "cedar-admin-tool"
  "cedar-archetype-exporter"
  "cedar-archetype-instance-reader"
  "cedar-archetype-instance-writer"
  "cedar-artifact-server"
  "cedar-cadsr-tools"
  "cedar-component-distribution"
  "cedar-docs"
  "cedar-impex-server"
  "cedar-internals-server"
  "cedar-openview"
  "cedar-openview-dist"
  "cedar-openview-server"
  "cedar-group-server"
  "cedar-model-validation-library"
  "cedar-messaging-server"
  "cedar-metadata-form"
  "cedar-mkdocs"
  "cedar-project"
  "cedar-repo-server"
  "cedar-resource-server"
  "cedar-schema-server"
  "cedar-server-core-library"
  "cedar-shared-data"
  "cedar-submission-server"
  "cedar-swagger-ui"
  "cedar-template-editor"
  "cedar-terminology-server"
  "cedar-user-server"
  "cedar-util"
  "cedar-valuerecommender-server"
  "cedar-worker-server"
  "cedar-embeddable-editor"
  "cedar-cee-demo-angular"
  "cedar-cee-demo-angular-dist"
  "cedar-cee-docs-angular"
  "cedar-cee-docs-angular-dist"
  "cedar-cee-demo-api-php"
)

for i in ${CEDAR_REPOS[@]}
do
    git clone https://github.com/metadatacenter/$i
done
