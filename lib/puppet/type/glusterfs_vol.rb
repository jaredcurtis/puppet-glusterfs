Puppet::Type.newtype(:glusterfs_vol) do
  desc 'Native type for managing glusterfs volumes'

  ensurable do
    defaultto(:present)
    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.destroy
    end
  end

  newparam(:volume, :namevar=>true) do
    desc 'Volume name'
    newvalues(/^\S+$/)
  end

  newparam(:stripe) do
    desc 'Number of stripes'
    newvalues(/^\d+$/)
  end

  newparam(:replica) do
    desc 'Number of replicas'
    newvalues(/^\d+$/)
  end

  newparam(:transport) do
    desc 'Gluster transport'
    defaultto :tcp
    newvalues(/tcp|rdma|tcp,rdma/)
  end

  newparam(:brick, :array_matching => :all) do
    desc 'List of bricks'
    newvalues(/\S+:\S+/)
  end

  newparam(:force, :boolean => true) do
    desc 'Whether to add the "force" flag when creating a volume or adding a brick'
    defaultto false
  end

  newparam(:delete) do
    desc 'delete brick'
    defaultto :false
    newvalues(/true|false/)
  end
end
