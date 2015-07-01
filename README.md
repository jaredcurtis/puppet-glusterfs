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

Using hiera:
```yaml
glusterfs::data_dir: '/data/glusterfs'
glusterfs::package::redhat::baseurl: 'https://download.gluster.org/pub/gluster/glusterfs/3.6/3.6.2/EPEL.repo/epel-6/x86_64/'
glusterfs::package::redhat::gpgkey: 'https://download.gluster.org/pub/gluster/glusterfs/3.6/3.6.2/EPEL.repo/pub.key'
glusterfs::package_ensure: '3.6.2-1.el6'
glusterfs::pool:
  GFS01:
    peer: '10.1.1.1'
glusterfs::volumes:
  volume_name:
    force: true
    replica: 2
    brick: ["%{ipaddress}:/data/glusterfs", "10.1.1.1:/data/glusterfs"]
```
