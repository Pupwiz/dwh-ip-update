#!/bin/bash

# TODO: Add some sort of error handling for this function.
getPublicIp() {
    local result=$(dig +short myip.opendns.com @resolver1.opendns.com)
    echo $result
}

if [ ! -f "ip_address.txt" ]; then
    ip_address=$(getPublicIp)
    echo  $ip_address > ip_address.txt
fi

current_ip_address=$(getPublicIp)
saved_ip_address=$(head ip_address.txt)

if [[ "$current_ip_address" != "$saved_ip_address" ]]; then
    # TODO: Add the cURL request to update Discord via webhook.
fi