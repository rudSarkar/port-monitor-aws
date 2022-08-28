from collections import defaultdict
import boto3

ec2 = boto3.resource('ec2', 'ap-southeast-1')

running_instances = ec2.instances.filter(Filters=[{
    'Name': 'instance-state-name',
    'Values': ['running']}])

ec2info = defaultdict()
for instance in running_instances:
    for tag in instance.tags:
        if 'Name' in tag['Key']:
            name = tag['Value']
    ec2info[instance.id] = {
        'Name': name,
        'Type': instance.instance_type,
        'State': instance.state['Name'],
        'Private IP': instance.private_ip_address,
        'Public IP': instance.public_ip_address,
        'Launch Time': instance.launch_time
    }

attributes = ['Public IP']
for instance_id, instance in ec2info.items():
    for key in attributes:
        print("{1}".format(key, instance[key]))
