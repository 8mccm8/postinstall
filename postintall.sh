#!/bin/bash
# # sh -c "$(curl -fsSL https://raw.githubusercontent.com/8mccm8/postinstall/main/postintall.sh)"

if which apt &> /dev/null; then
    install="apt install"
fi

if which dnf &> /dev/null;then
    install="dnf install"
fi

useradd -m ansible
${install} sudo
mkdir ~ansible/.ssh
cat <<_EOF > ~ansible/.ssh/authorized_keys
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICqHfLTy8Rs/HuAZnLS4Arnm1zxp0Dw1fEodAy+RMkzn postinstall@ansible
_EOF
chown -R ansible:ansible ~ansible/.ssh/
chmod 700 ~ansible/.ssh/
chmod 600 ~ansible/.ssh/authorized_keys
cat <<_EOF > /etc/sudoers.d/ansible
Defaults:ansible !requiretty
ansible ALL=(ALL) NOPASSWD: ALL
_EOF
chmod 600 /etc/sudoers.d/ansible

