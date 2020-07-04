#/bin/sh

sudo apt -y update
sudo apt -y upgrade

if !(cat ~/.bashrc | grep @dev.setup.sh); then
    printf "\n\n# Configuration from @dev.setup.sh script\n" $USER >> ~/.bashrc
    printf "# Updated by a setup script at $(date)\n" $USER >> ~/.bashrc
    printf "export PATH=$PATH\n" $USER >> ~/.bashrc
fi

if !(unzip --version); then
    sudo apt -y install unzip
fi

if !(zip --version); then
    sudo apt install zip
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
    sudo apt -y install tree
fi

if !(clang --version); then
    sudo apt -y install clang
    sudo apt -y install protobuf-c-compiler
fi

if !(g++ --version); then
    sudo apt -y install g++
fi


if !(figlet -v); then
    sudo apt -y install figlet
fi

if !(docker --version); then
    sudo apt -y install docker.io
    sudo groupadd docker
    sudo gpasswd -a $USER docker
fi

if !(docker-compose --version); then
    sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

if !(protoc --version); then
    curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v3.12.3/protoc-3.12.3-linux-x86_64.zip
    
    unzip protoc-3.12.3-linux-x86_64.zip -d protoc-3.12.3-linux-x86_64
    rm -rf protoc-3.12.3-linux-x86_64.zip

    sudo mv protoc-3.12.3-linux-x86_64/bin/protoc /usr/bin
    sudo mv protoc-3.12.3-linux-x86_64/include/* /usr/include
    rm -rf protoc-3.12.3-linux-x86_64

    curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v3.12.3/protobuf-cpp-3.12.3.tar.gz
    tar -xzf protobuf-cpp-3.12.3.tar.gz
    rm -rf protobuf-cpp-3.12.3.tar.gz
    
    cd protobuf-3.12.3 && ./configure
fi

if !(go version); then
    curl -LO https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.14.4.linux-amd64.tar.gz
    rm -rf go1.14.4.linux-amd64.tar.gz

    printf "\n\n# Updated by a setup script at $(date)\n" $USER >> ~/.bashrc
    printf "export PATH=\$PATH:/usr/local/go/bin\n" $USER >> ~/.bashrc
    printf "export GO111MODULE=on  # Enable module mode\n" $USER >> ~/.bashrc
    printf "export PATH=\"\$PATH:$(go env GOPATH)/bin\"\n" $USER >> ~/.bashrc

    go get github.com/golang/protobuf/protoc-gen-go
    go get google.golang.org/grpc
fi

if !(rustc --version); then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    
    printf "\n\n# Updated by a setup script at $(date)\n" $USER >> ~/.bashrc
    printf "export PATH=\$PATH:\$HOME/.cargo/bin\n" $USER >> ~/.bashrc

    cargo install bindgen
    cargo install --version 1.5.1 protobuf
fi

if (ls ~/.ssh | grep git_rsa); then
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/git_rsa
fi

figlet "Your ubuntu is ready :)"
echo "Done."
