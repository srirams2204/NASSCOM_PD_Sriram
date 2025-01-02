sudo apt-get update
mkdir -p openEDA
cd openEDA
#pre-requisite
echo "installing pre-requisite"
echo "___________________________________________________"
sudo apt-fast install build-essential clang bison flex \
	libreadline-dev gawk tcl-dev libffi-dev git \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev \
	make m4 tcsh csh libx11-dev gperf  tcl8.6-dev tk8.6 tk8.6-dev \
	libxmp4 libxpm-dev  libxcb1 libcairo2  \
      libxrender-dev libx11-xcb-dev libxaw7-dev freeglut3-dev automake yosys
sudo apt-get update
sudo apt-get -y install libtool
