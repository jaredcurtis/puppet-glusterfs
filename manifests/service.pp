# == Class: glusterfs::service
#
class glusterfs::service {

  service { 'glusterd':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['glusterfs-server']
  }

}
