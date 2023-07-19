**Jump into the folder**
`cd ./datagen-python/`

**Modify file confluent_python.config with your details**

**Create env**
`python3 -m virtualenv env`

**Activate env**
`source env/bin/activate`

**Install requirements**
`pip3 install -r requirements.txt`

**Run producer with config file & topic name**
`python3 streaming_kafka_datagen.py confluent_python.config product`

**Run 10 times**
`seq 1 10 | xargs -I{} python3 streaming_kafka_datagen.py confluent_python.config product`