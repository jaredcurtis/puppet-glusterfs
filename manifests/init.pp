# == Class: glusterfs
#
# Puppet module to install glusterfs
#
# === Parameters
#
# [*upstream*]
#   Install upstream glusterfs repositories.
#
# === Examples
#
#  class { glusterfs:
#    upstream => false,
#    server   => false
#  }
#
# === Authors
#
# Jared Curtis
# Merritt Krakowitzer
#
# === Copyright
#
# Copyright 2013
#
class glusterfs(
  $upstream = true,
) {
  class { 'glusterfs::package': } ~>
  class { 'glusterfs::service': }
}
