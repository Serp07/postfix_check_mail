#!/bin/bash
telegram_chat_id="CHAT_ID"
telegram_bot_token="TOKEN"
log="/var/log/check_email.txt"

ls /var/YOUR_DIR/ | grep -E 'mail...|mail' | while read -r email; do
count1=$(find /var/YOUR_DIR/"$email"/cur/ -maxdepth 1 -type f -name '*' | wc -l)
sleep 290
count2=$(find /var/YOUR_DIR/"$email"/cur/ -maxdepth 1 -type f -name '*' | wc -l)
c=$(echo "$count2-$count1" | bc -l)
if [ "$c" -gt 0 ]; then
    curl \
        --data parse_mode=HTML \
        --data chat_id=$telegram_chat_id \
        --data text="NEW LETTER <b>$email@EXAMPLE.COM</b> - <b>$c.</b>" \
        --request POST https://api.telegram.org/bot$telegram_bot_token/sendMessage > /dev/null; 2>&1 
fi
done

exit 0
