FROM python:3.9.12-slim-buster

# Install basic requirements
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    g++ \ 
    gcc \
    git \
    gnupg2 \ 
    graphviz \
    libboost-all-dev \
    libz3-dev \
    python3-pip \
    python3-dev \
    unzip \
    vim \
    wget \
    z3

# Install solc 0.5.7
WORKDIR /tmp
RUN git clone --depth 1 --branch v0.5.7 https://github.com/ethereum/solidity.git
WORKDIR /tmp/solidity/build
RUN cmake .. && make
RUN cp solc/solc /usr/bin/

# # Install Souffle dependencies
RUN apt-get install -y \
    autoconf \
    automake \
    clang \
    doxygen \
    flex \
    libffi-dev \
    libncurses5-dev \
    libtool \
    libsqlite3-dev \
    mcpp \
    sqlite \
    zlib1g-dev
WORKDIR /tmp
RUN wget http://ftp.de.debian.org/debian/pool/main/b/bison/bison_3.0.4.dfsg-1+b1_amd64.deb \
    && wget http://ftp.de.debian.org/debian/pool/main/b/bison/libbison-dev_3.0.4.dfsg-1+b1_amd64.deb \
    && dpkg -i libbison-dev_3.0.4.dfsg-1+b1_amd64.deb \
    && dpkg -i bison_3.0.4.dfsg-1+b1_amd64.deb

# # Install Souffle 1.5.1
WORKDIR /tmp
RUN git clone --depth 1 --branch 1.5.1 https://github.com/souffle-lang/souffle.git
WORKDIR /tmp/souffle
RUN sh ./bootstrap \
    && ./configure \
    && make \
    && make install

# Install test script requirements
RUN apt-get install -y bc

# install Python requirements
WORKDIR /root
COPY peck ./peck
COPY setup.py ./
RUN pip3 install -e .

# run code
COPY project ./project
WORKDIR /root/project

CMD ["/bin/bash"]
# add useful commads to bashrc
RUN touch ~/.bashrc && echo 'pr(){\npython ~/project/analyze.py ~/project/test_contracts/$1.sol\n}\nprv(){\npython ~/project/analyze.py --visualize ~/project/test_contracts/$1.sol\n}\n' >> ~/.bashrc
