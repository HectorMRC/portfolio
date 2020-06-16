#/bin/bash

# eval "$(ssh-agent -s)"
# if !(ssh-add ~/.ssh/git_rsa); then
#     return 1
# fi

if !(unzip --version); then
    sudo apt -y install unzip
fi

if !(autoconf --version); then
    sudo apt -y install autoconf
fi

if !(automake --version); then
    sudo apt -y install automake
fi

if !(libtool --version); then
    sudo apt -y install libtool
fi

if !(curl --version); then
    sudo apt -y install curl
fi

if !(make --version); then
    sudo apt -y install make
fi

if !(tree --version); then
    sudo apt install tree
fi

if !(g++ --version); then
    sudo apt install g++
fi

if !(figlet -v); then
    sudo apt install figlet
fi

if !(docker --version); then
    sudo apt install -y docker.io
    sudo groupadd docker
    sudo gpasswd -a $USER docker
fi

if !(protoc --version); then
    curl -LO https://github.com/protocolbuffers/protobuf/archive/v3.12.3.zip
    
    unzip v3.12.3.zip
    rm -rf v3.12.3.zip

    cd ./protobuf-3.12.3
    ./autogen.sh && ./configure
    make && make check && make install
    
    cd ..
    sudo ldconfig # refresh shared librery cache.
fi

if !(go version); then
    curl -LO https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.14.4.linux-amd64.tar.gz

    GO_VERSION=$(go version)
    if !(go version); then
        echo "Golang not reachable"
        return 1
    fi

    printf "\n\n# Added automatically by a setup script at $(date)" $USER >> ~/.bashrc
    printf "\nexport PATH=\$PATH:/usr/local/go/bin\n" $USER >> ~/.bashrc

    rm -rf go1.14.4.linux-amd64.tar.gz
fi

sudo apt update
sudo apt upgrade

figlet "This is your ubuntu :)"
echo "Done."
