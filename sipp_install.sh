#!/bin/bash

# Install dependencies
sudo yum groupinstall "Development Tools" -y
sudo yum install ncurses-compat-libs ncurses-devel wget openssl-devel pcap libpcap-devel libnet gsl -y

# Install CMake
wget https://cmake.org/files/v3.18/cmake-3.18.0.tar.gz
tar -xvzf cmake-3.18.0.tar.gz
cd cmake-3.18.0
./bootstrap
make
sudo make install
cd ..

# Clone and build SIPp
git clone https://github.com/SIPp/sipp.git
cd sipp
/usr/local/bin/cmake . -DUSE_PCAP=1 -DUSE_GSL=1
make

# Add SIPp to PATH
echo 'export PATH=$PATH:'$(pwd) >> ~/.bashrc
source ~/.bashrc

# Clean up
cd ..
rm -rf cmake-3.18.0 cmake-3.18.0.tar.gz

echo "SIPp installation complete. Please restart your terminal or run 'source ~/.bashrc' to use SIPp."
