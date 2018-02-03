Chef Cookbook - Linux Base
==============
This Chef cookbook will configure some basic system settings, add/remove some common packages, and deploy standard configurations for some common services  

Changes Performed
------------
1. Make sure CentOS has EPEL
2. Remove the following packages from Ubuntu-based systems
    1. landscape-client-ui
    2. landscape-client-ui-install
    3. landscape-client
    4. landscape-common
    5. update-motd
3. Install the following packages on Ubuntu-based systems
    1. bmon
    2. htop
    3. vim
    4. curl
    5. gnupg2
    6. atop
    7. git
    8. molly-guard
    9. python-pip
    10. python-dev
    11. python3-pip
    12. unzip
    13. psmisc
4. Install the following packages on CentOS-based systems
    1. vim-enhanced
    2. curl
    3. htop
    4. gnupg2
    5. git
    6. lsof
    7. telnet
    8. net-tools
    9. bmon
    10. atop
    11. wget
    12. python2-pip
    13. python34-pip
    14. python34-devel
    15. unzip
    16. gcc
    17. psmisc
    18. bind-utils
5. Make sure the `/tools` directory exists and is accessible only to root
6. install the following python2.7 packages
    1. urllib3
    2. pyasn1
7. Remove root's .bashrc on Ubuntu-based systems
8. Deploy a custom system-wide bashrc and a supporting git.bash file for working in git repos
9. Install thefuck in python3 and configure it with [Matthew Ahrenstein](https://www.ahrenstein.com)'s [custom rules](https://github.com/ahrenstein/thefuck-rules)
10. Install and configure ntp to run off the NTP pool using the America/New_York timezone

Requirements
------------
1. Chef (Tested on Chef 13)
2. Linux chef-clients (Tested on Ubuntu 14.04, Ubuntu 16.04 and CentOS 7.2 but kitchen will let you test anything you want)
3. The apt cookbook from Chef Supermarket
4. The yum-epel cookbook from Chef Supermarket

Installation Tips
------------

1. I personally use Berks to install this into my Chef server, because it's easier.

Limitations
------------
 1. None so far :)

Known Issues
------------
1. None so far :)

Bug Fixes & Changes
------------

1. v0.1.1
    1. Added psmisc package to all supported operating systems
    2. Added bind-utils to CentOS
2. v0.1.0
    1. Initial release

Use Cases
------------
Getting a minimum base configuration going on new Linux servers 

Donate To Support This Chef Cookbook
------------
Route 1337, LLC operates entirely on donations. If you find this cookbook useful, please consider donating via one of these methods.

1. Bitcoin: 1CnzzrPh3iirEkLRLiWFKXDV9i5TXHQjE2
2. Bitcoin Cash: qzcq645swgd87s7t5mmmjcumf4armhtjt5euww5c29
3. Litecoin: LWYbc9hf5ErJsF874Q3wwmMiASHRWgwrjR
4. Ethereum: 0x117543aa7a4D704849171cA06568Ece71B111D18

Thank you for your support!
