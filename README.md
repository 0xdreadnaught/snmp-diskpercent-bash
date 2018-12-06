# snmp-diskpercent-bash
get disk use percentages with snmp using bash

This was a quick work around for getting disk use percentages on systems that don't have the .1.3.6.1.4.1.2021.9 OID removed.
The script just grabs MIB data for used/capacity for each disk/partition in the system and calculates the difference. Currently it ommits any label that doesn't contain "/". This can easily be omitted if you want to pull memory and cache stats as well.
