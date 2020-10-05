#!/bin/bash

if [[ ! -f "~/.klei/DoNotStarveTogether/settings.ini" ]]; then
  mkdir -p ~/.klei/DoNotStarveTogether/
  touch ~/.klei/DoNotStarveTogether/settings.ini
fi

replace_config() {
  sed -i "s/${1}=.*/${1}=${2}/g" ~/.klei/DoNotStarveTogether/settings.ini
}
