#
# Script that copies Native Messaging manifest into the correct directory
# Currently supports Linux and OSX
#

# working location will be the one where script resides
PREV_PWD=$(pwd)
cd "$(dirname "$0")"

MANIFEST_NAME=com.webtraffic.annotator.json 
MANIFEST_LOCATION=NativeMessagingHostsManifest/$MANIFEST_NAME
USER=$(whoami)

# Check the user privileges - we need his name (macos)
if [ "$USER" == "root" ]; then 
    echo "Don't run this as sudo! you'll be prompted for sudo password if needed."
    exit 1
fi

exit;

# Stage 1 : Copy Manifest into correct place
LINUX_CHROME="~/.config/google-chrome/NativeMessagingHosts/"
LINUX_CHROMIUM="~/.config/chromium/NativeMessagingHosts/"
MACOS_CHROME="~/Library/Application Support/Google/Chrome/NativeMessagingHosts/"
MACOS_CHROMIUM="~/Library/Application Support/Chromium/NativeMessagingHosts/"


if [[ "$OSTYPE" == "linux-gnu"* ]] 
then
    # Linux paths
    if [ -d "$LINUX_CHROME" ]; then CORRECT_DIR="$LINUX_PATH1"
    elif [ -d "$LINUX_CHROMIUM" ]; then CORRECT_DIR="$LINUX_PATH2"
    fi
elif [[ "$OSTYPE" == "darwin"* ]] 
then
    # Mac OSX
    echo $MACOS_CHROME
    if [ -d "$MACOS_CHROME" ]; then echo "lol"
    elif [ -d "$MACOS_CHROMIUM" ]; then CORRECT_DIR="$MACOS_CHROMIUM"
    fi
fi    

exit


cp "$MANIFEST_LOCATION" "$CORRECT_DIR"

# Stage 2 : substitute path in copied manifest
NEW_PATH=$1

if [[ $NEW_PATH != "" ]]
then
    LOADED_MANIFEST=$CORRECT_DIR$MANIFEST_NAME
    sed -i'.original' -e "s+{SUBSTITUTE_THIS_FOR_A_PATH}+$NEW_PATH+" "$LOADED_MANIFEST"
else
    echo "You didn't provide path to the HttpDataReSender!"
    exit 1
fi
