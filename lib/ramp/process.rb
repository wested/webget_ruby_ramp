# Process extensions to help debug Ruby programs.
#
# ==Examples
#
#   p = Process.ps
#   puts p
#   => the results of the 'ps' command for the current process id
#
#   p = Process.ps(1234)
#   puts p
#   => the results of the 'ps' command for process id 1234
#
#   p = Process.pss
#   p['%cpu'] => percentage of cpu use, as a float
#   p['%mem'] => percentage of memory use, as a float
##

module Process


 # Return the 'ps' command as one long text string.
 # This is typically useful for logging to a text file.

 def self.ps(pid=Process.pid)
   `#{self.ps_command} #{pid.to_i}`
 end

 # Return the 'ps' command as a hash of keys and values.
 # OPTIMIZE: add dates, times
 def self.pss(pid=Process.pid)
   ps=self.ps(pid)
   h=Hash[self.ps_keys.zip(ps.split)]
   h['c']      =h['c'].to_i
   h['cp']     =h['cp'].to_f
   h['egid']   =h['egid'].to_i
   h['egroup'] =h['egroup'].to_i
   h['uid']    =h['uid'].to_i
   h['fgid']   =h['fgid'].to_i
   h['lwp']    =h['lwp'].to_i
   h['ni']     =h['ni'].to_i
   h['nlwp']   =h['nlwp'].to_i
   h['pcpu']   =h['pcpu'].to_f
   h['pgid']   =h['pgid'].to_i
   h['pid']    =h['pid'].to_i
   h['pmem']   =h['pmem'].to_f
   h['ppid']   =h['ppid'].to_i
   h['rgid']   =h['rgid'].to_i
   h['rss']    =h['rss'].to_i
   h['ruid']   =h['ruid'].to_i  
   h['sid']    =h['sid'].to_i  
   h['sgid']   =h['sgid'].to_i  
   h['suid']   =h['suid'].to_i  
   self.ps_aliases.each_pair{|k,v| h[k]=h[v]}
  return h
 end

  def self.ps_aliases
    @@ps_aliases||=Hash[%w'
    %cpu pcpu
    %mem pmem
    sig_block blocked
    sigmask blocked
    sig_catch caught
    sigcatch caught
    cls class
    cls policy
    cputime time
    gid egid 
    group egroup
    uid euid 
    uname euser
    user euser 
    flag f
    flags f
    fsuid fuid
    sig_ignore ignored
    sigignore ignored
    spid lwp 
    tid lwp 
    nice ni
    thcount nlwp
    sig pending 
    sig_pend pending
    pgrp pgid 
    rssize rss
    rsz rss
    state s
    sess sid
    session sid
    svgid sgid
    tt tname 
    tty tname 
    vsz vsize
  ']
 end


 def self.ps_aliases=(aliases)
  @@ps_aliases=aliases
 end


 def self.ps_keys
  @@ps_keys||=%w'blocked bsdtime c caught class cp egid egroup eip esp etime euid euser f fgid fgroup fuid fuser group ignored label lwp ni nlwp nwchan pending pcpu pgid pid pmem ppid pri psr rgid rgroup rss rtprio ruid ruser s sched sgi_p sgid sgroup sid sig size stackp start_time stat suid suser sz time tname tpgid vsize wchan'
 end
 
 def self.ps_keys=(keys)
  @@ps_keys=keys
 end

 def self.ps_command
  @@ps_command||='ps h ww -o '+self.ps_keys.join(',')
 end


 def self.ps_command=(command)
  @@ps_comannd=command
 end


end
