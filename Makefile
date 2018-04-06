#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
# https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents
# 
include .make/Makefile.inc

GCE_EMAIL                   := k8-gcloud@streaming-platform-devqa.iam.gserviceaccount.com
GCE_PROJECT                 := streaming-platform-devqa
GCE_CREDENTIALS_FILE_PATH   := /workspace/.auth/gcp-streaming-platform-devqa-e158812b35a9.json
GCE_INI_PATH                : $(PWD)/gce.ini
ANSIBLE_HOST_KEY_CHECKING   := False
INSTANCES                   ?= centos-1 iredmail-1 infra-monitoring-icinga-01
export

inventory/test:                     ; ansible tag_sandbox -i inventory/gce.py -m ping
inventory/save:                     ; inventory/gce.py --pretty --refresh-cache >inventory.json; cat inventory.json

network/dns:                        ; ansible-playbook dns-records.yml
network:                            ; ansible-playbook gce-network.yml

local/setupdev:                     ; ansible-playbook localdevenv.yml
## Create new instance(s): make instances/create INSTANCES=mytest-1 mytest-2
instances/create: guard-INSTANCES   ; @for I in $(INSTANCES); do ansible-playbook gce-instances-create.yml -e instances=$$I; done

## Change the state of an instance: make instances/state NAME=centos-1 STATE=started
instances/state:  guard-STATE\
                  guard-NAME        ; ansible-playbook gce-instances-state.yml -e NAME="$(NAME)" -e STATE="$(STATE)"

## Start all instances in $INSTANCES: make instances/start INSTANCES=centos-1
instances/start:                    ; for I in $(INSTANCES); do $(MAKE) instances/state STATE=started NAME=$$I; done

## Stop all instances in $INSTANCES: make instances/start INSTANCES=centos-1
instances/stop:                     ; for I in $(INSTANCES); do $(MAKE) instances/state STATE=stopped NAME=$$I; done

## Delete all instances in $INSTANCES: make instances/delete INSTANCES=centos-1
instances/delete: guard-INSTANCES   ; @for I in $(INSTANCES); do ansible-playbook gce-instances-delete.yml -e instances=$$I; done

cleanup:

	ansible-playbook gce-cleanup.yaml

_setup:

	cp ansible/contrib/inventory/gce.py inventory/
