# Check config cmdlog

echo "Config cmdlog for current user"
touch /var/log/cmdlog.log
chmod 600 /var/log/cmdlog.log

# Config for current user 
echo "# Command log" >> ~/.bashrc
echo "export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local6.debug \"[\$(echo \$SSH_CLIENT | cut -d\" \" -f1)] # \$(history 1 | sed \"s/^[ ]*[0-9]\+[ ]*//\" )\"'" >> ~/.bashrc
echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> ~/.bashrc
source ~/.bashrc


# Config for user add 
echo "# " >> ~/.bashrc
echo "alias useradd='adduser'" >> ~/.bashrc
mv /etc/default/{useradd,useradd.bk}

echo """# useradd defaults file
GROUP=100
HOME=/home
INACTIVE=-1
EXPIRE=
SHELL=/bin/sh
SKEL=/etc/skel
CREATE_MAIL_SPOOL=yes""" > /etc/default/useradd

mkdir -p /etc/skel
cp ./sources/u20.bashrc /etc/skel/.bashrc

cp ./sources/u20.profile /etc/skel/.profile

# Config rsyslog 
echo "Config rsyslog"
mv /etc/rsyslog.{conf,conf.bk}
echo "local6.*                /var/log/cmdlog.log" >> /etc/rsyslog.d/30-cmd.conf
systemctl restart rsyslog.service > /dev/null 2>&1 || service rsyslog restart > /dev/null 2>&1
source ~/.bashrc