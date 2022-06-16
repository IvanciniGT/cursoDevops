firewalld --version 1>/dev/null 2>&1
if [ $? == 0 ]; then
    echo firewalld
else
    ufw --version 1>/dev/null 2>&1
    if [ $? == 0 ]; then
        echo ufw
    else
        iptables --version 1>/dev/null 2>&1
        if [ $? == 0 ]; then
            echo iptables
        else
            echo Ninguno
        fi
    fi
fi


firewalld --version 1>/dev/null 2>&1 && echo firewalld || \
(ufw --version 1>/dev/null 2>&1 && echo ufw ||\
(iptables --version 1>/dev/null 2>&1 && echo iptables || \
echo ninguno    ))