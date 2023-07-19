**Modify the .env file**

**Run the docker-compose script**
```
$ docker-compose --env-file .env up
```

**Initialize MongoDB replica set**
```
$ docker exec -i mongodb mongosh --eval 'rs.initiate({_id: "myuser", members:[{_id: 0, host: "mongodb:27017"}]})'
```

**Create a MongoDB user profile**
```
$ docker exec -i mongodb mongosh << EOF
use admin
db.createUser(
{
user: "myuser",
pwd: "mypassword",
roles: ["dbOwner"]
}
)
EOF
```

**Create a connector**
```
source .env

curl -X PUT \
     -H "Content-Type: application/json" \
     -d "$(cat <<EOF
          {
            "connector.class" : "com.mongodb.kafka.connect.MongoSourceConnector",
            "key.converter": "org.apache.kafka.connect.json.JsonConverter",
            "key.converter.schema.registry.url": "$CCLOUD_SCHEMA_REGISTRY:8081",
            "key.converter.schemas.enable": "false",
            "value.converter.schemas.enable": "false",
            "value.converter": "org.apache.kafka.connect.json.JsonConverter",
            "value.converter.schema.registry.url": "$CCLOUD_SCHEMA_REGISTRY:8081",
            "tasks.max" : "1",
            "connection.uri" : "mongodb://myuser:mypassword@mongodb:27017",
            "database":"inventory",
            "collection":"customers",
            "topic.prefix":"mongo",
            "topics":"mongo.inventory.customers"
}
EOF
)" \
     http://localhost:8083/connectors/mongodb-source/config | jq .
```

**Insert entry in DB**
```
docker exec -i mongodb mongosh << EOF
use inventory
db.customers.insertOne([
{ _id : 1006, first_name : 'Bob', last_name : 'Hopper', email : 'thebob@example.com' }
]);
EOF
```

**Check successful DB entry**
```
docker exec -i mongodb mongosh << EOF
use inventory
db.customers.find().pretty();
EOF
```

**Check entry**
```
kafkacat -b $CCLOUD_BOOTSTRAP_SERVER -C -t mongo.inventory.customers -X security.protocol=SASL_SSL -X sasl.mechanisms=PLAIN -X sasl.username=$CCLOUD_API_KEY -X sasl.password=$CCLOUD_API_SECRET
```

**Check status of the connectors**
```
curl -s "http://localhost:8083/connectors"| \
  jq '.[]'| \
  xargs -I{connector_name} curl -s "http://localhost:8083/connectors/"{connector_name}"/status" | \
  jq -c -M '[.name,.connector.state,.tasks[].state]|join(":|:")' | \
  column -s : -t | \
  sed 's/\"//g' | \
  sort

curl -i -X GET http://localhost:8083/connectors/mongodb-source/status | jq
```

**Delete the connectors**
```
curl -i -X DELETE http://localhost:8083/connectors/mongodb-source
```