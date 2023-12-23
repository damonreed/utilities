##
## utilities/macos-ssh-setup.sh - initialize key and setup to use keychain for key passphrase
##

# scp $KEY_LOCATION ~/.ssh/id_rsa
# chmod 600 ~/.ssh/id_rsa

# if no key - ssh-keygen -b 4096 -t rsa

ssh-add --apple-use-keychain ~/.ssh/id_rsa
cat > ~/.ssh/config << EOF
Host *
    UseKeychain yes
    AddKeysToAgent yes
    IdentityFile ~/.ssh/id_rsa
EOF