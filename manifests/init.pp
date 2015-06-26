# == Class: glusterfs
#
# Puppet module to install glusterfs
#
# === Parameters
#
# [*upstream*]
#   Install upstream glusterfs repositories.
# [*pool*]
#   Pool of servers to pair with
# [*volumes*]
#   List of volumes to create/start
# [*data_dir*]
#   Optional path to be created before volumes are created/started
#
# === Examples
#
#  class { glusterfs:
#    upstream => false,
#    pool => {"server1" => {"peer" => "10.0.2.1"}}
#    volumes => {"vol_name" => {"brick" => "10.0.2.1:/something"}}
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
  $pool = {},
  $volumes = {},
  $data_dir = undef
) {
  class { 'glusterfs::package': } ~>
  class { 'glusterfs::service': }

  if ($data_dir) {
    validate_absolute_path($data_dir)
    exec {'create glusterfs data dir':
      command => "/bin/mkdir -p $data_dir",
      creates => "$data_dir",
      before => Class['glusterfs::volumes']
    }
  }

  include glusterfs::pool
  include glusterfs::volumes
}
