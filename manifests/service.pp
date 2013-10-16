# == Class: glusterfs::service
#
class glusterfs::service {

  service { 'glusterd':
    ensure    => running,
    hasstatus => true,
    require   => Package['glusterfs-server']
  }

}
