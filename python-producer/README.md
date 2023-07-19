**Jump into the folder**<br>
`cd ./datagen-python/`

**Modify file confluent_python.config with your details** <br>

**Create env**<br>
`python3 -m virtualenv env`

**Activate env**<br>
`source env/bin/activate`

**Install requirements**<br>
`pip3 install -r requirements.txt`

**Run producer with config file & topic name**<br>
`python3 streaming_kafka_datagen.py confluent_python.config product`

**Run 10 times**<br>
`seq 1 10 | xargs -I{} python3 streaming_kafka_datagen.py confluent_python.config product`