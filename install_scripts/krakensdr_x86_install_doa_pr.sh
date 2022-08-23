sudo apt update
sudo apt -y install build-essential git cmake libusb-1.0-0-dev lsof libzmq3-dev clang php-cli nodejs gpsd

git clone https://github.com/krakenrf/librtlsdr
cd librtlsdr
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON
make
sudo make install
sudo ldconfig

echo 'blacklist dvb_usb_rtl28xxu' | sudo tee --append /etc/modprobe.d/blacklist-dvb_usb_rtl28xxu.conf

git clone https://github.com/krakenrf/kfr
cd kfr
mkdir build
cd build
cmake -DENABLE_CAPI_BUILD=ON -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Release ..
make

sudo cp ~/kfr/build/lib/* /usr/local/lib
sudo mkdir /usr/include/kfr
sudo cp ~/kfr/include/kfr/capi.h /usr/include/kfr
sudo ldconfig

cd
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
chmod ug+x Miniforge3-Linux-x86_64.sh
./Miniforge3-Linux-x86_64.sh -b

export PATH=/home/krakenrf/miniforge3/bin/:$PATH
conda init
conda config --set auto_activate_base false

conda create -n kraken python=3.9.7
conda activate kraken

conda install -y scipy
conda install -y numba
conda install -y configparser
conda install -y pyzmq
conda install -y scikit-rf con

cd
mkdir krakensdr_doa
cd krakensdr_doa

git clone https://github.com/krakenrf/heimdall_daq_fw
cd heimdall_daq_fw

cd ~/krakensdr_doa/heimdall_daq_fw/Firmware/_daq_core/
make

conda install -y quart
conda install -y pandas
conda install -y orjson
conda install -y matplotlib
conda install -y requests

pip3 install dash_bootstrap_components==1.1.0
pip3 install quart_compress
pip3 install dash_devices
pip3 install pyargus

conda install dash==1.20.0
conda install werkzeug==2.0.2

pip3 install gpsd-py3

cd ~/krakensdr_doa
git clone https://github.com/krakenrf/krakensdr_doa
cp krakensdr_doa/util/kraken_doa_start.sh .
cp krakensdr_doa/util/kraken_doa_stop.sh .
