# dwh-ip-update

Shell script designed to be used with cron that uses cURL to consume a Discord webhook to provide an announcement when a host's IP address changes.

## Setting Up
After obtaining a webhook URL from Discord, create a text file in the same folder as the script named ```webhook_url.txt``` and copy the webhook URL there.

## Using the Script
Once you have created the required files, you can execute the script. The script will work as outlined below:
- The script checks first to see if there is a file named ```ip_address.txt``` in the same folder. 
- If there is not, we get the current IP address and save it to that file. We then call cURL and consume the webhook.
- If there is, the contents are compared against the current IP adddress and if there is a change, cURL is called and the webhook is consumed.
- If there is no change, nothing is called and the script exits.