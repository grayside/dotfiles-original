# This will enable Boxen on your machine.
if [ -f /opt/boxen/env.sh ]; then
  . /opt/boxen/env.sh
fi

# This will check for global settings on the server.
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
