##
## utilities/macos-cli-setup.sh - setup basic toolset for cli and dev operations
##

#
# UPDATE THESE VARIABLES WITH YOUR OWN INFORMATION
#
export NAME="Damon Reed"
export EMAIL="dreed@nomadia.org"
export OPENAI_API_KEY="sk-<your key here>"

# Add OPEN_AI_API_KEY to ~/.zshrc
cat << EOF >> ~/.zshrc
export OPENAI_API_KEY=$OPENAI_API_KEY
EOF

# Create ~/.ssh if it doesn't exist with correct permissions
mkdir -p ~/.ssh && chmod 700 ~/.ssh

# If id_rsa is present in ~/Downloads, move it to ~/.ssh
if [ -f ~/Downloads/id_rsa ]; then
    echo "id_rsa found in ~/Downloads, copying to ~/.ssh"
    cp ~/.ssh/id_rsa ~/.ssh/id_rsa.bak
    mv ~/Downloads/id_rsa ~/.ssh/id_rsa
    chmod 600 ~/.ssh/id_rsa
fi

# If id_rsa is present in ~/Downloads or ~/.ssh, move it to ~/.ssh, else generate a new key
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "id_rsa not found in ~/,ssh, generating new private and public keys"
    ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa
    # create public key
    ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
    cat ~/.ssh/id_rsa.pub
fi

# add key to keychain and config
ssh-add --apple-use-keychain ~/.ssh/id_rsa
cat > ~/.ssh/config << EOF
Host *
    UseKeychain yes
    AddKeysToAgent yes
    IdentityFile ~/.ssh/id_rsa
EOF

# install brew if /opt/homebrew/bin/brew not installed
if [ ! -f /opt/homebrew/bin/brew ];
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

# Make src directory if it doesn't exist, and clone damonreed/utilities from github repo
mkdir -p ~/src
cd ~/src
git config --global user.email $EMAIL
git config --global user.name $NAME
git config --global pull.rebase false
git clone https://github.com/damonreed/utilities.git

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
gcloud auth application-default login

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


