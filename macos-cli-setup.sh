##
## utilities/macos-cli-setup.sh - setup basic toolset for cli and dev operations
##

# Create ~/.ssh if it doesn't exist with correct permissions
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# If id_rsa is present in ./Downloads, copy it to ~/.ssh, else generate a new key
if [ -f ~/Downloads/id_rsa ]; then
    echo "id_rsa found in ~/Downloads, copying to ~/.ssh"
    cp ~/Downloads/id_rsa ~/.ssh/id_rsa
    chmod 600 ~/.ssh/id_rsa
else
    echo "id_rsa not found in ~/Downloads, generating new key"
    ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa
    # create public key
    ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
fi

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

# Add brew to path
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# install iterm2 if not installed
if ! command -v iterm2 &> /dev/null
then
    echo "iterm2 not found, installing..."
    brew install --cask iterm2
fi

# install xcode if not installed
if ! command -v xcode-select &> /dev/null
then
    echo "xcode not found, installing..."
    xcode-select --install
fi

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

# install docker if not installed
if ! command -v docker &> /dev/null
then
    echo "docker not found, installing..."
    brew install --cask docker
fi

# install terraform if not installed
if ! command -v terraform &> /dev/null
then
    echo "terraform not found, installing..."
    brew install terraform
fi


