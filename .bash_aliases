alias ls='ls --color=auto'
alias ll='ls -la'

alias nano='nano -w'
alias screenie='xwd -screen > screenie'

# 2007-04-01
alias rattler='ssh -l msn290 rattler.few.vu.nl'

# 2007-04-11
alias galjas='ssh -l msn290 galjas.cs.vu.nl'

# 2007-07-23
alias rattler_proxy='ssh -L 8080:www-proxy.cs.vu.nl:8080 msn290@rattler.few.vu.nl'
alias testie_erik='ssh -p 2222 -X testie@pi.homeunix.net'

# 2007-08-08
alias vim='vim -p'

# 2007-10-05
alias kits='ssh msn290@kits.cs.vu.nl'
alias kits_proxy='ssh -L 8080:www-proxy.cs.vu.nl:8080 msn290@kits.cs.vu.nl'

# 2012-08-24 / 2008-01-20
alias higgs='ssh higgs'

# 2008-07-20
alias backuppc='ssh aquatix@bhaile.murf.nl -L 8888:vacdepot.bhaile.murf.nl:80'
alias backuppc_browse='x-www-browser http://localhost:8888/backuppc/'

# 2009-03-30
alias soleusconsole='ssh aquatix@console.soleus.nu'

# 2009-11-25
#alias U='svn update'

# 2012-08-24 / 2010-04-03
alias medusa='ssh medusa'

# 2012-08-24 / 2012-03-23
alias devteam='ssh devteam'

function fuck() {
  if killall -9 "$2"; then
    echo ; echo " (╯°□°）╯︵$(echo "$2"|toilet -f term -F rotate)"; echo
  fi
}
