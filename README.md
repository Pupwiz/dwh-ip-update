# dwh-ip-update

Shell script designed to be used with cron that uses cURL to consume a Discord webhook to provide an announcement when a host's IP address changes.

## Setting Up
After obtaining a webhook URL from Discord, create a text file in the same folder as the script called ```webhook_url.txt``` and copy the webhook URL there. Make sure no other content is in this file.

## Using the Script
Once you have created the required files, you can execute the script. It works by checking to see if there is a file called ```ip_address.txt``` in the same folder as the script. If there is, it then compares the IP address saved in the file to what the current IP address is. If there is a change, the file is deleted and replaced with a new file containing the new IP address.