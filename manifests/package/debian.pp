# Class: glusterfs::package::debian
#
# This module manages glusterfs package installation on debian based systems
#
class glusterfs::package::debian(
  #$location        = '',
  #$key             = '' ,
  #$key_source      = '',
  $debian_packages = ['glusterfs-common','glusterfs-server','glusterfs-client'],
) {

  package { $debian_packages:
    ensure  => installed,
    require => Anchor['glusterfs::apt_repo'],
  }

  anchor { 'glusterfs::apt_repo': }

#  apt::source { 'glusterfs':
#    location   => $location,
#    repos      => 'glusterfs',
#    key        => $key,
#    key_source => $key_source,
#  }

}
