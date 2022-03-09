#!/bin/sh

mongod --fork --dbpath ${MONGO_DB_PATH} \
       --logpath ${MONGO_LOG_PATH}/mongodb.log
mongo <<EOF
    use admin
    db.createUser(
        {
            user:  "${CEDAR_MONGO_ROOT_USER_NAME}",
	    pwd:   "${CEDAR_MONGO_ROOT_USER_PASSWORD}",
	    roles: [ { role: "root", db: "admin" } ]
        }
    )
    use cedar
    db.createUser(
        {
	    user:  "${CEDAR_MONGO_APP_USER_NAME}",
	    pwd:   "${CEDAR_MONGO_APP_USER_PASSWORD}",
	    roles: [ "readWrite" ]
        }
     )
EOF
mongod --shutdown

cp ${MONGO_CONFIG_DIR}/mongod.conf /etc/mongod.conf
