#!/bin/bash

. /usr/local/osmosix/service/utils/cfgutil.sh

exec > >(tee -a /usr/local/osmosix/logs/service.log) 2>&1
OSSVC_HOME=/usr/local/osmosix/service
. /usr/local/osmosix/etc/userenv
. $OSSVC_HOME/utils/cfgutil.sh
. $OSSVC_HOME/utils/os_info_util.sh
curl -sSL https://get.docker.com/ | sh
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash
sudo apt-get install gitlab-ci-multi-runner
sudo gitlab-ci-multi-runner register \
  --non-interactive \
  --url "https://gitlab.asynchrony.com/ci" \
  --registration-token "$regToken" \
  --description "$runnerDesc" \
  --executor "docker" \
  --docker-image ruby:2.3.4
