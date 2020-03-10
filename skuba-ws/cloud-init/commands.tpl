  - echo "solver.onlyRequires = true" >> /etc/zypp/zypp.conf
  - [ zypper, ref ]
  - [ zypper, up, -y ]
  - [ zypper, -n, install, ${packages} ]
  - [ ip, link, delete, docker0 ]
  - iptables -L | grep DOCKER | awk {'print $2'} | xargs -d "\n" -i iptables -X {}
  - iptables-save | awk '/^[*]/ { print $1 "\nCOMMIT" }' | iptables-restore
  - lsmod | egrep ^iptable_ | awk '{print $1}' | xargs -rd\\n modprobe -r
