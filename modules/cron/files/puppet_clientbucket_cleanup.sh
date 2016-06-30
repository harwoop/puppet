#!/bin/bash

# Script designed to purge empty directories from $Target directory left over by Puppet
# Separate cron job will delete files in this directory $Target which are aged
# This script will recursively remove empty directories left over from bottom upwards
# ls -ld command cannot delete directories containing sub-directories or containing files

Target=/var/lib/puppet/clientbucket
ls -ld ${Target}/?/?/?/?/?/?/?/?/????????????????????????????????
ls -ld ${Target}/?/?/?/?/?/?/?/?
ls -ld ${Target}/?/?/?/?/?/?/?
ls -ld ${Target}/?/?/?/?/?/?
ls -ld ${Target}/?/?/?/?/?
ls -ld ${Target}/?/?/?/?
ls -ld ${Target}/?/?/?