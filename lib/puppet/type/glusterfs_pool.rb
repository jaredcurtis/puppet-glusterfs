Puppet::Type.newtype(:glusterfs_pool) do
  desc 'Native type for managing glusterfs pools'

  ensurable do
    defaultto(:present)
    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.destroy
    end
  end

  newparam(:peer, :namevar=>true) do
    desc 'Trusted server peer'
    newvalues(/^\S+$/)
  end
end
