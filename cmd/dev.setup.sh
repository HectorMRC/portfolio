#/bin/bash

# eval "$(ssh-agent -s)"
# if !(ssh-add ~/.ssh/git_rsa); then
#     return 1
# fi

if !(docker --version); then
    sudo apt install -y docker.io
    sudo groupadd docker
    sudo gpasswd -a $USER docker
fi

if !(go version); then
    curl -LO https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.14.4.linux-amd64.tar.gz

    GO_VERSION=$(go version)
    if !(go version); then
        echo "Golang not reachable"
        return 1
    fi

    rm -rf go1.14.4.linux-amd64.tar.gz
    printf "\n\n# Added automatically by a setup script at $(date)" $USER >> ~/.bashrc
    printf "\nexport PATH=\$PATH:/usr/local/go/bin\n" $USER >> ~/.bashrc
fi

if !(tree --version); then
    sudo apt install tree
fi

if !(figlet -v); then
    sudo apt install figlet
fi

figlet "This is your ubuntu :)"
echo "Done."
