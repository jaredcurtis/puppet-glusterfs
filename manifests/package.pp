# Class: glusterfs::package
#
# This module manages GlusterFS package installation
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class glusterfs::package {
  anchor { 'glusterfs::package::begin': }
  anchor { 'glusterfs::package::end': }

  case $::osfamily {
    'redhat': {
      class { 'glusterfs::package::redhat':
        require => Anchor['glusterfs::package::begin'],
        before  => Anchor['glusterfs::package::end'],
      }
    }
    'debian': {
      class { 'glusterfs::package::debian':
        require => Anchor['glusterfs::package::begin'],
        before  => Anchor['glusterfs::package::end'],
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }
}
