##
## utilities/macos-ssh-setup.sh - initialize key and setup to use keychain for key passphrase
##

# if no key - ssh-keygen -b 4096 -t rsa

ssh-add --apple-use-keychain ~/.ssh/id_rsa
cat > ~/.ssh/id_rsa << EOF
Host *
    UseKeychain yes
    AddKeysToAgent yes
    IdentityFile ~/.ssh/id_rsa
EOF