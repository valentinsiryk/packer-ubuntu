#!/bin/sh -eux

if [ -z "$ADMIN_USER" ]; then
  echo 'Expected ADMIN_USER var. Skipping...'; exit 0
fi

sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers;

# Set up password-less sudo for the admin user
echo "$ADMIN_USER ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/99_${ADMIN_USER};
chmod 440 /etc/sudoers.d/99_${ADMIN_USER};
