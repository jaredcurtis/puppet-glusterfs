class glusterfs::volumes (
  $volumes = $glusterfs::volumes
) {
  create_resources(glusterfs_vol, $volumes)
}