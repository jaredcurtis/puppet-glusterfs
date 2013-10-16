# Class: glusterfs::package::redhat
#
# This module manages glusterfs package installation on RedHat based systems
#
class glusterfs::package::redhat(
  # Allow for overide of yum repo with hiera
  $baseurl  = "http://download.gluster.org/pub/gluster/glusterfs/LATEST/EPEL.repo/epel-${::lsbmajdistrelease}/\$basearch/",
  $gpgkey   = 'http://download.gluster.org/pub/gluster/glusterfs/LATEST/EPEL.repo/pub.key',
  $enabled  = '1',
  $priority = '1',
  $redhat_packages = ['glusterfs','glusterfs-server','glusterfs-fuse' ],
) {

  if $::glusterfs::upstream == true {

    yumrepo { 'gluster-release':
      baseurl  => $baseurl,
      descr    => 'glusterfs latest repo',
      enabled  => $enabled,
      gpgcheck => '1',
      priority => $priority,
      gpgkey   => $gpgkey,
    }

    Yumrepo['gluster-release'] -> Package[$redhat_packages]

    #Define file for glusterfs-repo so puppet doesn't delete it
    file { '/etc/yum.repos.d/gluster-release.repo': ensure => present, }
  }

  package { $redhat_packages:
    ensure  => $glusterfs::package_ensure,
  }

}
