<!--
#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
#-->

[![Clickity click](https://img.shields.io/badge/k8s%20by%20example%20yo-limit%20time-ff69b4.svg?style=flat-square)](https://k8.matthewdavis.io)
[![Twitter Follow](https://img.shields.io/twitter/follow/yomateod.svg?label=Follow&style=flat-square)](https://twitter.com/yomateod) [![Skype Contact](https://img.shields.io/badge/skype%20id-appsoa-blue.svg?style=flat-square)](skype:appsoa?chat)

# Control Google Cloud Platform with ansible by Example

## Requirements

```bash
pip install ansible
pip install pycrypto
pip install apache-libcloud
```

## Google Compute Engine

### Creating Instances

```bash
$ ansible-playbook gce-instances-create.yml -e instances=test-01,test-02

PLAY [Create instance(s)] ******************************************************************************************************TASK [Launch instances] ********************************************************************************************************changed: [127.0.0.1]
TASK [Wait for SSH to come up] *************************************************************************************************
ok: [127.0.0.1] => (item={u'status': u'RUNNING', u'network': u'default', u'zone': u'us-central1-a', u'tags': [u'test'], u'image': u'centos-7-v20180314', u'disks': [u'test-01'], u'name': u'test-01', u'public_ip': u'104.197.64.187', u'private_ip': u'10.128.0.7', u'machine_type': u'n1-standard-1', u'subnetwork': u'default', u'metadata': {}})
ok: [127.0.0.1] => (item={u'status': u'RUNNING', u'network': u'default', u'zone': u'us-central1-a', u'tags': [u'test'], u'image': u'centos-7-v20180314', u'disks': [u'test-02'], u'name': u'test-02', u'public_ip': u'35.188.121.115', u'private_ip': u'10.128.0.8', u'machine_type': u'n1-standard-1', u'subnetwork': u'default', u'metadata': {}})

TASK [Add host to groupname] ***************************************************************************************************
changed: [127.0.0.1] => (item={u'status': u'RUNNING', u'network': u'default', u'zone': u'us-central1-a', u'tags': [u'test'], u'image': u'centos-7-v20180314', u'disks': [u'test-01'], u'name': u'test-01', u'public_ip': u'104.197.64.187', u'private_ip': u'10.128.0.7', u'machine_type': u'n1-standard-1', u'subnetwork': u'default', u'metadata': {}})
changed: [127.0.0.1] => (item={u'status': u'RUNNING', u'network': u'default', u'zone': u'us-central1-a', u'tags': [u'test'], u'image': u'centos-7-v20180314', u'disks': [u'test-02'], u'name': u'test-02', u'public_ip': u'35.188.121.115', u'private_ip': u'10.128.0.8', u'machine_type': u'n1-standard-1', u'subnetwork': u'default', u'metadata': {}})

PLAY RECAP *********************************************************************************************************************
127.0.0.1                  : ok=3    changed=2    unreachable=0    failed=0
```

### Deleting Instances

```bash
$ ansible-playbook gce-instances-delete.yml -e instances=test-01,test-02

PLAY [Delete instance(s)] *******************************************************************************************************
TASK [Destroy instances] ********************************************************************************************************changed: [127.0.0.1]

PLAY RECAP **********************************************************************************************************************127.0.0.1                  : ok=1    changed=1    unreachable=0    failed=0
```