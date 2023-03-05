# Gentoo Laptop Tools
 Some of my custom bash scripts to manage / automate my Gentoo install's power profiles /misc.

### Current State:

by adding "*/5 * * * * /usr/bin/sudo /home/kerem/.scripts/deneme.sh >> /home/kerem/.scripts/log.txt" to the sudo's chrontab entry, enable automatic charging level on ThinkPad laptops (only limited to thinkpads for now)

requires " https://github.com/teleshoes/tpacpi-bat " to work.

-doas or sudo'less implemention is on development, sometimes creates small hicckups on realtime systems due to use of sudo/doas command.
-should not be used with tpacpi-bat's systemctl daemon! otherivise every 1 minute current changements gets overwritten.
-intended to being used with open-rc gentoo setups. but can be also used with oher distributions.

### How to enable
1. create a folder named .scripts on your home directory
2. extract the _deneme.sh_ to .scripts
3. if exists, delete logs.txt
4. edit TARGETHOUR on deneme.sh to your battery life target (integers only, 6 --> 6 hours of desired battery charge)
5. edit INIT variable to your minimum charge treshold ( 1-100 integers only)
6. edit MAX to your maximum charge limit ( 2-100 integers only )
7. edit GAP to set start-stop tresholds ( if maximum treshold of 95 is selected for example, a charge stop treshold of 90 would be applied (starts charging if below 90 and charges to 95) )
8. change every /kerem/ to your username
9. fix "AVGALL=${AVGALL%%,*}" according to your locale
10. install tpacpi-bat and *do not enable* the systemd service!
11. add  "*/5 * * * * /usr/bin/sudo /home/YOURUSER/.scripts/deneme.sh >> /home/YOURUSER/.scripts/log.txt" to sudo crontab by tyipng "sudo crontab -e" and editing the config file
12. Now the script should be running every 5 minutes (unless being plugged to power)

## TODO's
1. Replace /kerem/'s tih /$USER/
2. integrate tpacpi-bat to the script
3. make script portable and run without the use of the chrontab
4. rewrite everything to become a sole daemon (as like the implementation of the battery charging on macOS)
5. automatic desired target hour implemention according to the powerusage.txt
