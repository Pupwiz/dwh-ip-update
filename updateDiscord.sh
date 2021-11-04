#!/bin/bash

# TODO: Add some sort of error handling for this function.
getPublicIp() {
    local result=$(dig +short myip.opendns.com @resolver1.opendns.com)
    echo $result
}

sendUpdate() {
    local ip_address=$1
    local webhook_url=$2
    curl -H "Content-Type: application/json" -d "{\"embeds\": [{ \"title\": \"⚠️ IP Address Updated\", \"description\": \"When connecting to the servers, please use the new IP address below: \n \`\`\`$ip_address\`\`\`\" ,\"color\": 16698189}]}" "$webhook_url"
}

if [ ! -f "webhook_url.txt" ]; then
    echo "Could not find webhook_url.txt."
    exit 1 
fi 

if [ ! -f "ip_address.txt" ]; then
    ip_address=$(getPublicIp)
    echo  $ip_address > ip_address.txt

    webhook_url=$(head webhook_url.txt)
    sendUpdate $ip_address $webhook_url
    exit 0
fi

current_ip_address=$(getPublicIp)
saved_ip_address=$(head ip_address.txt)

if [[ "$current_ip_address" != "$saved_ip_address" ]]; then
    ip_address=$(getPublicIp)
    rm ip_address.txt
    echo  $ip_address > ip_address.txt

    webhook_url=$(head webhook_url.txt)
    sendUpdate $ip_address $webhook_url

    exit 0
fi