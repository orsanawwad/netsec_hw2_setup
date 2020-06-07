FROM python:3.8-slim

LABEL maintainer="Orsan Awwad"

RUN apt update

RUN apt update && \
    apt install -y \
    python-setuptools \
    python-pip \
    python-dev \
    wget \
    build-essential \
    bison \
    flex \
    libpcap-dev \
    libpcre3-dev \
    libdumbnet-dev \
    zlib1g-dev \
    iptables-dev \
    libnetfilter-queue1 \
    tcpdump \
    unzip \
    nmap \
    apache2 \
    apache2-utils \
    squid \
    vim && pip install -U pip dpkt snortunsock

# Define working directory.
WORKDIR /opt

ENV DAQ_VERSION 2.0.6
RUN wget https://www.snort.org/downloads/archive/snort/daq-${DAQ_VERSION}.tar.gz \
    && tar xvfz daq-${DAQ_VERSION}.tar.gz \
    && cd daq-${DAQ_VERSION} \
    && ./configure; make; make install

ENV SNORT_VERSION 2.9.8.2
RUN wget https://www.snort.org/downloads/archive/snort/snort-${SNORT_VERSION}.tar.gz \
    && tar xvfz snort-${SNORT_VERSION}.tar.gz \
    && cd snort-${SNORT_VERSION} \
    && ./configure; make; make install

RUN ldconfig

# snortunsock
RUN wget --no-check-certificate \
        https://github.com/John-Lin/snortunsock/archive/master.zip \
    && unzip master.zip

# ENV SNORT_RULES_SNAPSHOT 2972
# ADD snortrules-snapshot-${SNORT_RULES_SNAPSHOT} /opt
# ADD mysnortrules /opt
# RUN mkdir -p /var/log/snort && \
#     mkdir -p /usr/local/lib/snort_dynamicrules && \
#     mkdir -p /etc/snort && \
#     # mkdir -p /etc/snort/rules && \
#     # mkdir -p /etc/snort/preproc_rules && \
#     # mkdir -p /etc/snort/so_rules && \
#     # mkdir -p /etc/snort/etc && \

#     # mysnortrules rules
#     cp -r /opt/rules /etc/snort/rules && \
#     # Due to empty folder so mkdir
#     mkdir -p /etc/snort/preproc_rules && \
#     mkdir -p /etc/snort/so_rules && \
#     # cp -r /opt/preproc_rules /etc/snort/preproc_rules && \
#     # cp -r /opt/so_rules /etc/snort/so_rules && \
#     cp -r /opt/etc /etc/snort/etc && \

#     # snapshot2972 rules
#     # cp -r /opt/rules /etc/snort/rules && \
#     # cp -r /opt/preproc_rules /etc/snort/preproc_rules && \
#     # cp -r /opt/so_rules /etc/snort/so_rules && \
#     # cp -r /opt/etc /etc/snort/etc && \

#     # touch /etc/snort/rules/local.rules && \
#     touch /etc/snort/rules/white_list.rules /etc/snort/rules/black_list.rules

#RUN apt install -y gcc libpcre3-dev zlib1g-dev libluajit-5.1-dev \
#    libpcap-dev openssl libssl-dev libnghttp2-dev libdumbnet-dev \
#    bison flex libdnet autoconf libtool

#RUN mkdir /opt/snort_src

#WORKDIR /opt/snort_src

#RUN apt install -y wget

#RUN wget https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz

#RUN tar -xvzf daq-2.0.7.tar.gz

#WORKDIR /opt/snort_src/daq-2.0.7

#RUN autoreconf -f -i

#RUN ./configure --enable-sourcefire && make && sudo make install

RUN pip install scapy-python3

RUN mkdir -p /opt/data/        

RUN apt install -y net-tools \
                   iputils-ping \
                   iproute2
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    /opt/snort-${SNORT_VERSION}.tar.gz /opt/daq-${DAQ_VERSION}.tar.gz
    
CMD ["/bin/bash"]
