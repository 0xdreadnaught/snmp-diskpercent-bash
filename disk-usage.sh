labels=($(snmpwalk -v3 -l authPriv -u <username> -a MD5 -A <authpass> -x AES -X <privpass> <ip> HOST-RESOURCES-MIB::hrStorageDescr | awk '{print $4}')) 
ids=($(snmpwalk -v3 -l authPriv -u <username> -a MD5 -A <authpass> -x AES -X <privpass> <ip> HOST-RESOURCES-MIB::hrStorageIndex | awk '{print $4}')) 
capacity=($(snmpwalk -v3 -l authPriv -u <username> -a MD5 -A <authpass> -x AES -X <privpass> <ip> HOST-RESOURCES-MIB::hrStorageSize | awk '{print $4}')) 
used=($(snmpwalk -v3 -l authPriv -u <username> -a MD5 -A <authpass> -x AES -X <privpass> <ip> HOST-RESOURCES-MIB::hrStorageUsed | awk '{print $4}'))

tick=0
for i in "${ids[@]}"
do
  if [[ "${labels[$tick]}" == *"/"* ]]; then
    x="${used[$tick]}"
    y="${capacity[$tick]}"
    if [[ "$x" == "0" ]]; then
      echo "[${labels[$tick]}] 0%"
    elif [[ "$x" == "$y" ]]; then
      echo "[${labels[$tick]}] 100%"
    else
      percent=$(echo $(( 10000 * $x / $y )) | sed 's/..$/.&/')
      echo "[${labels[$tick]}] $percent%"
    fi
  fi
  ((tick++))
done
