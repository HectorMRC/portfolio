#/bin/sh

sudo apt -y update
sudo apt -y upgrade

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
    #npm install grpc-web
    curl -LO https://github.com/grpc/grpc-web/releases/download/1.2.0/protoc-gen-grpc-web-1.2.0-linux-x86_64
    sudo mv ~/protoc-gen-grpc-web-1.2.0-linux-x86_64 /usr/local/bin/protoc-gen-grpc-web
    chmod +x /usr/local/bin/protoc-gen-grpc-web
fi

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