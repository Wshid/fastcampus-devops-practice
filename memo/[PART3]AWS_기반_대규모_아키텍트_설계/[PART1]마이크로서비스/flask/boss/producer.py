import pika # rabiitmq를 위한 패키지
import json

parmas = pika.URLParameters('amqps://xki...')

connection = pika.BlockingConnection(params)

channel = connection.channel()

# producer와 유사
def publish(method, body):
    properties = pika.BasicProperties(method)
    channel.basic_publish(exchange='', routing_key='order', body=json.dumps(body), properties=properties)

