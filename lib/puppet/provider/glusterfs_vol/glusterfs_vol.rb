require 'puppet'
Puppet::Type.type(:glusterfs_vol).provide(:glusterfs) do

  commands :glusterfs => 'gluster'
  defaultfor :feature => :posix

  def create
    opts = ['volume', 'create', resource[:name]]
    if resource[:stripe] then
      opts << "stripe" 
      opts << resource[:stripe]
    end
    
    if resource[:replica] then
      opts << "replica" 
      opts << resource[:replica]
    end

    if resource[:transport] then
      opts << "transport"
      opts << resource[:transport]
    end

    if resource[:brick] then
      opts << resource[:brick]
    end
    

    begin
      volinfo = glusterfs('volume', 'info', resource[:name])
    rescue Exception => e
      self.debug "Volume does not exist, creating it"
      glusterfs(opts)
      glusterfs('volume', 'start', resource[:name])
    end

    case volinfo
      when /Status: Stopped/
        self.debug "Starting volume"
        glusterfs('volume', 'start', resource[:name])
    end
  end

  def destroy
    self.debug "Stop volume"
    system "echo 'y' | gluster volume stop #{resource[:name]}"
    if resource[:delete]
      self.debug "Delete volume"
      system "echo 'y' | gluster volume delete #{resource[:name]}"
    end
  end

  def exists?
    begin
      volinfo = glusterfs('volume', 'info', resource[:name])
    rescue Exception => e
      #self.debug e.message
      #self.debug e.backtrace
      return false
    end

    self.debug "Checking for missing bricks"
    opts = []
    if resource[:stripe] then
      opts << "stripe" 
      opts << resource[:stripe]
    end
    
    if resource[:replica] then
      opts << "replica" 
      opts << resource[:replica]
    end

   missing_brick = []
    resource[:brick].map do |brick|
      if not volinfo =~ /Brick\d+:\s#{Regexp.escape(brick)}/ 
        self.debug "#{brick} is missing from the volume"
        missing_brick << brick
      end
    end
    if not missing_brick.empty?
      self.debug "Adding missing bricks"
      glusterfs('volume', 'add-brick', resource[:name], opts, missing_brick)
    else
      self.debug "All bricks are present"
    end

    case volinfo
      when /^No volumes present$/
        self.debug "No volumes present"
        return false
      when /^Volume #{resource[:name]} does not exist$/
        self.debug "Volume #{resource[:name]} does not exist"
        return false
      when /Status:\s+Started/
        self.debug "Volume is started"
        return true
      when /Status:\s+Stopped/
        self.debug "Volume is stopped"
        return false
      else
        self.debug "unaccounted for case"
        self.debug volinfo
        return false
    end
  end
end
