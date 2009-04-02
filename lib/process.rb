# Process extensions to help debug Ruby programs.
#
# ==Examples
#
#   puts Process.ps_text
#   => print the raw ps text
#
#   hash = Process.ps_hash
#   => each key is a ps field name, each value is the string value
#
#   hash = Process.ps
#   => same as ps_hash, with typecasting and aliases
#
#   Process.ps['pcpu']
#   => percentage of cpu use, as a float
#
#   Process.ps['pmem']
#   => percentage of memory use, as a float
##

module Process

  PS_KEYS=%w'blocked bsdtime c caught class cp egid egroup eip esp etime euid euser f fgid fgroup fuid fuser group ignored label lwp ni nlwp nwchan pending pcpu pgid pid pmem ppid pri psr rgid rgroup rss rtprio ruid ruser s sched sgi_p sgid sgroup sid sig size stackp start_time stat suid suser sz time tname tpgid vsize wchan'

  PS_COMMAND='ps h ww -o '+PS_KEYS.join(',')

  PS_ALIASES=Hash[%w'
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

 # Return the 'ps' method parsed into integers, floats, etc., also including aliases.
 # OPTIMIZE: add dates, times
 def self.ps(pid=Process.pid)
   ps=self.ps_hash(pid)
   ps['c']      =ps['c'].to_i
   ps['cp']     =ps['cp'].to_f
   ps['egid']   =ps['egid'].to_i
   ps['egroup'] =ps['egroup'].to_i
   ps['uid']    =ps['uid'].to_i
   ps['fgid']   =ps['fgid'].to_i
   ps['lwp']    =ps['lwp'].to_i
   ps['ni']     =ps['ni'].to_i
   ps['nlwp']   =ps['nlwp'].to_i
   ps['pcpu']   =ps['pcpu'].to_f
   ps['pgid']   =ps['pgid'].to_i
   ps['pid']    =ps['pid'].to_i
   ps['pmem']   =ps['pmem'].to_f
   ps['ppid']   =ps['ppid'].to_i
   ps['rgid']   =ps['rgid'].to_i
   ps['rss']    =ps['rss'].to_i
   ps['ruid']   =ps['ruid'].to_i  
   ps['sid']    =ps['sid'].to_i  
   ps['sgid']   =ps['sgid'].to_i  
   ps['suid']   =ps['suid'].to_i  
   PS_ALIASES.each_pair{|k,v| ps[k]=ps[v]}
  return ps
 end


 # Return the 'ps' command as a hash of column name keys and values.
 # This is particularly useful to skip the time cost of typecasting.

 def self.ps_hash(pid=Process.pid)
   Hash[PS_KEYS.zip(ps_text(pid).split)]
 end


 # Return the 'ps' command in tab delimited format (tdf).
 # This is particularly useful for logging to a spreadsheet.

 def self.ps_tdf(pid=Process.pid)
   self.ps_text.split.join("\t")
 end


 # Return the 'ps' command as one long text string.
 # This is particularly useful for logging to a text file.

 def self.ps_text(pid=Process.pid)
   `#{PS_COMMAND} #{pid.to_i}`
 end

end
