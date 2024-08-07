#!/usr/bin/env python3

import boto3
import json
import argparse

def fetch_ec2_instances(region):
    ec2 = boto3.client('ec2', region_name=region)
    response = ec2.describe_instances()
    
    inventory = {'_meta': {'hostvars': {}}}
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            public_ip = instance.get('PublicIpAddress', None)
            private_ip = instance.get('PrivateIpAddress', None)
            
            if 'Tags' in instance:
                tags = {tag['Key']: tag['Value'] for tag in instance['Tags']}
            else:
                tags = {}

            # Add instance to inventory
            inventory['all'] = inventory.get('all', {'hosts': []})
            inventory['all']['hosts'].append(instance_id)
            
            # Add host variables
            inventory['_meta']['hostvars'][instance_id] = {
                'public_ip': public_ip,
                'private_ip': private_ip,
                **tags
            }
    
    return inventory

def main():
    parser = argparse.ArgumentParser(description='AWS EC2 Dynamic Inventory')
    parser.add_argument('--region', required=True, help='AWS region')
    args = parser.parse_args()
    
    inventory = fetch_ec2_instances(args.region)
    print(json.dumps(inventory, indent=2))

if __name__ == '__main__':
    main()
