puppet-glusterfs
================

GlusterFS type

Usage
=====

node 'storage01' {
  glusterfs_pool { ['192.168.1.100', '192.168.1.101']: } ->
  glusterfs_vol { 'data':
    replica => 2,
    brick   => ['192.168.1.100:/mnt/brick', '192.168.1.101:/mnt/brick'],
  }
}
