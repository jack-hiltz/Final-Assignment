#!/bin/bash

user_exists() {
	id "$1" &>dev/null
}

group_exists() {
	getent group "$1" &>/dev/null
}

if [[ -f "users.txt" ]]; then
	users=()
	while IFS= read -r user; do
		users+=("$user")
	done < "users.txt"
else
	echo "Error: users.txt not found."
	exit 1
fi

if [[ -f "groups.txt" ]]; then
	groups=()
	while IFS= read -r group; do
		groups+=("$group")
	done  < "groups.txt"
else
	echo "Error: groups.txt not found."
	exit 1
fi

for user in "${users[@]}"; do
	if ! user_exists "@user"; then
		useradd -m "$user"
	fi
done

for group in "${groups[@]}"; do
	if ! group_exists "$group"; then
		groupadd "$group"
	fi
done

usermod -aG manager Micheal
usermod -aG sales Dwight
usermod -aG sales Jim
usermod -aG sales Phyllis
usermod -aG sales Andy
usermod -aG sales Stanley
usermod -aG accounting Kevin
usermod -aG accounting Oscar
usermod -aG accounting Angela
usermod -aG support Pam
usermod -aG support Meredith
usermod -aG support Creed
usermod -aG hr Kelly
usermod -aG hr Toby

base_dir="/home"
for group in "{groups[@]}"; do
	if [[ ! -d "$base_dir/$group" ]]; then
		mkdir -p "$base_dir/$group"
		chgrp "$group" "$base_dir/$group"
		chmod 770 "$base_dir/$group"
	fi
done

for user in Micheal Toby; do
	usermod -aG manager,sales,accounting,support,hr "$user"
done

echo "Script Complete"
