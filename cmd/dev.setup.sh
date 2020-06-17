#/bin/sh

# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/git_rsa)

sudo apt -y update
sudo apt -y upgrade

### ESSENTIAL TOOLS ###

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

### BACKEND TOOLS ###

if !(docker --version); then
    sudo apt -y install docker.io
    sudo groupadd docker
    sudo gpasswd -a $USER docker
fi

if !(protoc --version); then
    curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v3.12.3/protoc-3.12.3-linux-x86_64.zip
    
    unzip protoc-3.12.3-linux-x86_64.zip -d protoc-3.12.3-linux-x86_64
    rm -rf protoc-3.12.3-linux-x86_64.zip

    sudo mv protoc-3.12.3-linux-x86_64/bin/protoc /usr/bin
    sudo mv protoc-3.12.3-linux-x86_64/include/* /usr/include
    rm -rf protoc-3.12.3-linux-x86_64
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
fi

if !(rustc --version); then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    
    printf "\n\n# Updated by a setup script at $(date)\n" $USER >> ~/.bashrc
    printf "export PATH=\$PATH:\$HOME/.cargo/bin\n" $USER >> ~/.bashrc

    cargo install bindgen
    cargo install --version 1.5.1 protobuf
fi

### FRONTEND TOOLS ###

if !(npm --version); then
    sudo apt -y install npm
    sudo npm install npm@latest -g
fi

if !(npm view react version); then
    npm install react
    npm install -g create-react-app
fi

if !(npm view typescript version); then
    npm install typescript --save-dev
    npm install protobuf-typescript
    npm install ts-protoc-gen
fi

if !(npm view grpc-web version); then
    npm install grpc-web
fi

# Flutter installation
# if !(flutter --version); then
#     curl -LO https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_1.17.3-stable.tar.xz
#     tar -xf flutter_linux_1.17.3-stable.tar.xz
#     
#     rm -rf flutter_linux_1.17.3-stable.tar.xz
#     sudo mv flutter /usr/local
# 
#     printf "\n\n# Updated by a setup script at $(date)\n" $USER >> ~/.bashrc
#     printf "export PATH=\$PATH:/usr/local/flutter/bin\n" $USER >> ~/.bashrc
# 
#     flutter --verbose precache
#     flutter --verbose doctor
# fi

figlet "This is your ubuntu :)"
echo "Done."
