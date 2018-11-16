import paho.mqtt.client as mqtt
import time
from threading import Thread
import random
import requests
import sys
import simplejson as json

def publishData(clientt, topic, delay_time, count):
    while count > 0:
        data = random.normalvariate(mean, deviation)
        dataToSend = "value=" + str(data)
        print(dataToSend)
        clientt.publish(topic, data, 0)

        url = topic + str(data)
        res = requests.post(url, data={}, headers={})

        time.sleep(delay_time)
        count = count - 1
    clientt.loop_stop()
    clientt.disconnect()

def initializeSensorsClusters(mean, deviation, nodedns, X):
    print("We are initializing " + str(X) + " sensors into the PostgreSQL database...")
    for si in range(X):
        name = 'Sensor ' + str(si+1)
        url = 'http://' + nodedns + ':3000/api/sensor/' + str(si+1) + '/' + name;
        res = requests.post(url, data={}, headers={})
        if (res.status_code != requests.codes.ok):
            print("Sensor " + name + " already exists in the PostgreSQL database")
    
    url = 'http://' + nodedns + ':3000/api/cluster/' + str(mean) + '/' + str(deviation)
    res = requests.get(url, data={}, headers={})
    if (res.status_code != requests.codes.ok):
        res = requests.post(url, data={}, headers={})
        res = requests.get(url, data={}, headers={})

    reqObj = json.loads(res.text)
    clusterid = reqObj["data"]["clusterid"]
    return clusterid

def on_connect(client, userdata, rc):
    print("Connected with result code " + str(rc))
	
def on_message(client, userdata, msg):
    print(msg.topic + " " + str(msg.payload))



if len(sys.argv) > 1:
    print('Mean: ', sys.argv[1])
    mean = float(sys.argv[1])
else:
    mean = float(input("Please enter mean value? "))

if len(sys.argv) > 2:
    print('Deviation: ', sys.argv[2])
    deviation = float(sys.argv[2])
else:
    deviation = float(input("Please enter deviation value? "))

if len(sys.argv) > 3:
    print('Number of Sources: ', sys.argv[3])
    X = int(sys.argv[3])
else:
    X = input("Please enter Number of Sources? ")

if len(sys.argv) > 4:
    print('Delay: ', sys.argv[4], ' seconds')
    Y = int(sys.argv[4])
else:
    Y = input("Please enter delaying time in seconds? ")

if len(sys.argv) > 5:
    print('NodeJS API DNS: ', sys.argv[5])
    nodedns = sys.argv[5]
else:
    nodedns = input("Please enter the NodeJS API public DNS for your PostgreSQL database (Leave it blank / empty for default value = locahost)  ? ")
    if len(nodedns) == 0:
        nodedns = 'localhost'



clusterID = initializeSensorsClusters(mean, deviation, nodedns, X)
	
clients = [mqtt.Client("Sensor"+str(i)) for i in range(X)]
for i in range(X):
    clients[i].on_connect = on_connect
    clients[i].on_message = on_message
    clients[i].connect("127.0.0.1", 1883, 60)
    clients[i].loop_start()
    

curlData = 'http://' + nodedns + ':3000/api/data/' + str(clusterID) + '/'
try:
    sensors = [Thread(name='sensor'+str(i), target=publishData, args=(clients[i], curlData + str(i+1) + '/', Y, 20)) for i in range(X)]
    for i in range(X):
        sensors[i].start()
except:
    print("Error: unable to start thread")

while 1:
    pass
 
