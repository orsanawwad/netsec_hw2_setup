#!/bin/bash

ip route add 172.16.38.0/24 via 172.16.148.2 dev eth0
ip route add 172.16.75.0/24 via 172.16.148.2 dev eth0