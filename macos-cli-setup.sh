##
## utilities/macos-setup.sh - initialize ssh key and core utilities
##

# scp {{KEY_LOCATION}} ~/.ssh/id_rsa || 
# chmod 600 ~/.ssh/id_rsa

# if no key - ssh-keygen -b 4096 -t rsa

# add key to keychain and config
ssh-add --apple-use-keychain ~/.ssh/id_rsa
cat > ~/.ssh/config << EOF
Host *
    UseKeychain yes
    AddKeysToAgent yes
    IdentityFile ~/.ssh/id_rsa
EOF

# install brew if not installed
if ! command -v brew &> /dev/null
then
    echo "brew not found, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install iterm2 if not installed
if ! command -v iterm2 &> /dev/null
then
    echo "iterm2 not found, installing..."
    brew install --cask iterm2
fi

# install xcode if not installed


# install github cli if not installed
if ! command -v gh &> /dev/null
then
    echo "gh not found, installing..."
    brew install gh
fi

# install gcloud cli if not installed
if ! command -v gcloud &> /dev/null
then
    echo "gcloud not found, installing..."
    brew install --cask google-cloud-sdk
fi

# install chrome if not installed
if ! command -v google-chrome &> /dev/null
then
    echo "chrome not found, installing..."
    brew install --cask google-chrome
fi

# install vscode if not installed
if ! command -v code &> /dev/null
then
    echo "vscode not found, installing..."
    brew install --cask visual-studio-code
fi

# install terraform if not installed
if ! command -v terraform &> /dev/null
then
    echo "terraform not found, installing..."
    brew install terraform
fi

# install docker if not installed
if ! command -v docker &> /dev/null
then
    echo "docker not found, installing..."
    brew install --cask docker
fi


