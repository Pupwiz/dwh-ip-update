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

# TODO: Add a first run handler

if [[ "$current_ip_address" != "$saved_ip_address" ]]; then
    rm ip_address.txt
    ip_address=$(getPublicIp)
    echo  $ip_address > ip_address.txt

    # TODO: Add some sort of error handling for failing to read or find this file.
    webhook_url=$(head webhook_url.txt)
    curl -H "Content-Type: application/json" -d "{\"embeds\": [{ \"title\": \"⚠️ IP Address Updated\", \"description\": \"When connecting to the servers, please use the new IP address below: \n \`\`\` $ip_address \`\`\`\" ,\"color\": 16698189}]}" "$webhook_url"
fi