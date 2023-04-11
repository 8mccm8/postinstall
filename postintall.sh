#!/bin/bash
# # sh -c "$(curl -fsSL https://raw.githubusercontent.com/8mccm8/postinstall/main/postintall.sh)"



if [ $# -eq 1 ]; then
param=$1     
else
    exit 1;
fi
if [ $param != ced ] || [ $param != dub ] ; then
	exit 1;
fi
echo "les parametres sont bons";
exit 1;

if which apt &> /dev/null; then
    install="apt install"
fi

if which apt-get &> /dev/null; then
    install="apt-get install"
fi

if which dnf &> /dev/null;then
    install="dnf install"
fi

useradd -m ansible
${install} sudo
mkdir ~ansible/.ssh
if [ $param = ced ] ; then
cat <<_EOF > ~ansible/.ssh/authorized_keys
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzOvrSAZoPbYL3QapT6cVBHZWaPnDgcJ5Jsle9WCAve
_EOF
fi
if [ $param = dub ] ; then
cat <<_EOF > ~ansible/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDfxJe1qd2+ElyTn2Mt09PrzfOD3+SGXl9ZO/CNxBbGdpOLi7leU0mu6bdxp6fdRowx70Pb06ZVYANkGiaXa3GUjROkagttIah768UDo19F1IxIYrgoLG6znLUic6U2JM/pzkKThsGG2L7IqifGbMG+ZjVK8Z0496eOqLebjEDdy7/lCfN2W5pJsfS5lcORGv2gNSLO21tqNaihsn9WydnwQjhWE5p9L0G+t2rKRMM6q3SeLKFLJRLWaYopgQ2XFIyX2RXfrYcQvkaHQrb5DRzkRzn2lwd67yyIVlTdR8X29Sdza99dIhAoji9UoSPXrs7U6iJtUuegqhDdfsuY0q9xaL7gOSfBAFjHsElgQydqOEdtxZUctryLnwKLj3Bs2oZi1NoCsv7+Yav4gCud67dQ5oUP7vuQECsUq/WNNqjPEEY3IjDiYDKGbuBkzu1mw3nRBoTc9eRBNwR9inin3BwFaBT73tToiTQIhIjugd50CJ/E6u1jYQmskGG1/bdh5ffi9l2AEYHQqvIYxUr6OCN4iQjBwec0KfHrNS2nS/Br9fnWoHknI/2SFB8ln+2ka97iBrVdFcf2cuaq5pGuRDp/aKct+Z3bZvb4sCI/w6PpH0txk99c/StVx0JXJ9V/PATyUjnKnrnfz+xZxWQBPMG0SSbj+lHlysTtqKQeGm3SUw== ansible@nicdu40.fr
_EOF
fi

chown -R ansible:ansible ~ansible/.ssh/
chmod 700 ~ansible/.ssh/
chmod 600 ~ansible/.ssh/authorized_keys
cat <<_EOF > /etc/sudoers.d/ansible
Defaults:ansible !requiretty
ansible ALL=(ALL) NOPASSWD: ALL
_EOF
chmod 600 /etc/sudoers.d/ansible
#test
