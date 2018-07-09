#!/bin/sh -eux

SSHD_CONFIG="/etc/ssh/sshd_config"

# ensure that there is a trailing newline before attempting to concatenate
sed -i -e '$a\' "$SSHD_CONFIG"

set_sshd_option() {
    KEY="$1"
    VALUE="$2"
    
    if grep -q -E "^[[:space:]]*${KEY}" "$SSHD_CONFIG"; then
        sed -i "s/^\s*${KEY}.*/${KEY} ${VALUE}/" "$SSHD_CONFIG"
    else
        echo "${KEY} ${VALUE}" >>"$SSHD_CONFIG"
    fi
}

set_sshd_option 'UseDNS' 'no'
set_sshd_option 'GSSAPIAuthentication' 'no'
set_sshd_option 'PermitRootLogin' 'without-password'
set_sshd_option 'PasswordAuthentication' 'no'


mkdir -p $HOME_DIR/.ssh/ /root/.ssh/

if [ -e $SSH_PUBLIC_KEY_FILE_TMP_PATH ]; then
    cat $SSH_PUBLIC_KEY_FILE_TMP_PATH | tee -a $HOME_DIR/.ssh/authorized_keys /root/.ssh/authorized_keys
fi
