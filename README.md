puppet-glusterfs
================

GlusterFS type

This is a beta release. Please review and test carefully before using in production.

Usage
=====
```puppet
node /storage/ {
  class { 'glusterfs': }
  glusterfs_pool { ['192.168.1.100', '192.168.1.101']: } ->
  glusterfs_vol { 'data':
    replica => 2,
    brick   => ['192.168.1.100:/mnt/brick', '192.168.1.101:/mnt/brick'],
  }
}
```
