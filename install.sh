#!/bin/sh
set -eux

DEFAULT_PKGS="cmake software-properties-common wget bison flex make git software-properties-common gpg gpg-agent build-essential time lcov"
LLVM_PKGS="clang-format-${LLVM_VERSION} clang-tidy-${LLVM_VERSION} lldb-${LLVM_VERSION}"
GUI_PKGS="qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5opengl5-dev libgtk-3-0 default-jre"
DEV_PKGS="vim tig net-tools iputils-ping net-tools iputils-ping openssh-client openssh-server gedit bear"

if [ "$1" = "dev" ]; then
  INSTALL_PKGS="${DEFAULT_PKGS} ${LLVM_PKGS} ${GUI_PKGS} ${DEV_PKGS}"
elif [ "$1" = "ci" ]; then
  INSTALL_PKGS="${DEFAULT_PKGS} ${LLVM_PKGS}"
fi

PYTHON_PKGS="python${PYTHON_VERSION} python${PYTHON_VERSION}-dev libpython${PYTHON_VERSION}-dev python${PYTHON_VERSION}-distutils"

echo "Installing packages: ${INSTALL_PKGS}"
apt-get update -y
apt-get install -y --no-install-recommends ${INSTALL_PKGS}

ln -sf /usr/bin/clang-format-${LLVM_VERSION} /usr/bin/clang-format
ln -sf /usr/bin/clang-tidy-${LLVM_VERSION} /usr/bin/clang-tidy
ln -sf /usr/bin/clang-${LLVM_VERSION} /usr/bin/clang
ln -sf /usr/bin/clang++-${LLVM_VERSION} /usr/bin/clang++
ln -sf /usr/bin/llvm-profdata-${LLVM_VERSION} /usr/bin/llvm-profdata
ln -sf /usr/bin/llvm-cov-${LLVM_VERSION} /usr/bin/llvm-cov

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub --progress=dot:giga | apt-key add -
add-apt-repository ppa:deadsnakes/ppa
apt-get update -y
apt-get install -y --no-install-recommends ${PYTHON_PKGS}

wget https://bootstrap.pypa.io/get-pip.py --progress=dot:giga
python${PYTHON_VERSION} ./get-pip.py
rm get-pip.py
pip${PYTHON_VERSION} install numpy scipy pandas matplotlib posix_ipc
ln -s /usr/bin/python${PYTHON_VERSION} /usr/local/bin/python
ln -s /usr/bin/python${PYTHON_VERSION} /usr/local/bin/python3
apt-get autoremove -y
apt-get clean
rm -r /var/lib/apt/lists/*
