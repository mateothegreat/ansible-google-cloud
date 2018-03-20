#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
include .make/Makefile.inc
 
# GCE_EMAIL                   := k8-gcloud@streaming-platform-devqa.iam.gserviceaccount.com
# GCE_PROJECT                 := streaming-platform-devqa
# GCE_CREDENTIALS_FILE_PATH   := /workspace/.auth/gcp-streaming-platform-devqa-e158812b35a9.json
# GCE_INI_PATH                : $(PWD)/gce.ini
# ANSIBLE_HOSTS               := ansible_hosts
# ANSIBLE_HOST_KEY_CHECKING   := False
# export

.PHONY: inventory

cleanup:

	ansible-playbook gce-cleanup.yaml


inventory:

	inventory/gce.py --pretty --refresh-cache >inventory.json
	cat inventory.json

create: guard-INSTANCES; ansible-playbook gce-instances-create.yaml -e instances=$(INSTANCES)

test:

	# ansible -i inventory role=sandbox -m ping
	ansible tag_sandbox -i inventory/gce.py -m ping

_setup:

	cp ansible/contrib/inventory/gce.py inventory/