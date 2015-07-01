class glusterfs::pool(
  $pool = $glusterfs::pool
) {
  create_resources(glusterfs_pool, $pool, {"require" => Service['glusterd'], "before" => Class['glusterfs::volumes']})
}