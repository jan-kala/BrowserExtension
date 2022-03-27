if [[ "$OSTYPE" == "linux-gnu"* ]] 
then
    # Linux paths
    if [ -d "/usr/lib/mozilla/native-messaging-hosts/" ] 
    then
        cp NativeMessagingHostsManifest/Firefox/com.kala.anotator.json /usr/lib/mozilla/native-messaging-hosts/
    elif [ -d "/usr/lib64/mozilla/native-messaging-hosts/" ] 
    then
        cp NativeMessagingHostsManifest/Firefox/com.kala.anotator.json /usr/lib64/mozilla/native-messaging-hosts/
    fi
elif [[ "$OSTYPE" == "darwin"* ]] 
then
    echo "Ahoj"
    # Mac OSX
    if [ -d "/Library/Application Support/Mozilla/NativeMessagingHosts" ] 
    then
        cp NativeMessagingHostsManifest/Firefox/com.kala.anotator.json /Library/Application\ Support/Mozilla/NativeMessagingHosts/
    elif [ -d "/Users/$(whoami)/Library/Application Support/Mozilla/NativeMessagingHosts" ] 
    then
        echo "Ahoj"
        cp NativeMessagingHostsManifest/Firefox/com.kala.anotator.json ~/Library/Application\ Support/Mozilla/NativeMessagingHosts/
    fi
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
        ls
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
        ls
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
        ls
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
        ls
else
        # Unknown
        ls
fi    