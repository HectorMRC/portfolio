#/bin/bash

# eval "$(ssh-agent -s)"
# if !(ssh-add ~/.ssh/github_rsa); then
#     return 1
# fi

if !(docker --version); then
    sudo apt install -y docker.io
    sudo groupadd docker
    sudo gpasswd -a $USER docker
fi

# export PATH=$PATH:/usr/local/go/bin
if !(go version); then
    curl -LO https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.14.4.linux-amd64.tar.gz

    GO_VERSION=$(go version)
    if !(go version); then
        echo "Golang not reachable"
        return 1
    fi

    echo "Golang installed properly"
    rm -rf go1.14.4.linux-amd64.tar.gz
fi

#if $(cat ~/.profile | grep ~/setup.sh); then
#    echo "Done."
#else
#    echo "Welcome to your ubuntu!"
#    printf "\n# File updates from setup script" >> ~/.profile
#    printf "\n# Origin: github.com/alvidir/my-ubuntu" >> ~/.profile
#    printf "\nsource ~/setup.sh\n" >> ~/.profile
#fi

echo "Done."
