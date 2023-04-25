#!/bin/bash
set -e
#!/bin/bash

line="* * * * * rm -f /home/sdasgupta/dcc/metrics.json"
(crontab -u root -l; echo "$line" ) | crontab -u root -
line="* * * * * rm -f /home/sdasgupta/dcc/health.json"
(crontab -u root -l; echo "$line" ) | crontab -u root -