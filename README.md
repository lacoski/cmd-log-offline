# Cấu hình CMD Logs Offline

Hỗ trợ:
- Ubuntu 20.04

Cách sử dụng:
```
git clone https://github.com/lacoski/cmd-log-offline.git
cd cmd-log-offline/
bash u20.sh
```

Bổ sung user cho tồn tại CMD Log
```
# Config for current user 
echo "# Command log" >> ~/.bashrc
echo "export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local6.debug \"[\$(echo \$SSH_CLIENT | cut -d\" \" -f1)] # \$(history 1 | sed \"s/^[ ]*[0-9]\+[ ]*//\" )\"'" >> ~/.bashrc
echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> ~/.bashrc
source ~/.bashrc
```