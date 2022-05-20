# Browser Extension
Browser part of Web Traffic Anotator. Observes incoming/outcoming HTTP requests and provides their metadata for pairing with network flows. 
Uses new V3 version of manifest file that can be used on Chromium based browsers. 

For communication with Joiner process, that pairs data with network flows, uses HttpDataReSender in [Daemons](https://github.com/jan-kala/Daemons) repository. For this communication to work correctly, please follow the steps described in this README or you can use setup script in [parent repository](https://github.com/jan-kala/WebTrafficAnnotator).

# Set up
Only fully supported browsers are now Google Chrome, Chromium or any other similar browser (Opera, Brave, ...) There are extra steps that needs to be done for your extension to work as expected. You can run script `setup.sh` that performs these steps or you can do them manually.

## `setup.sh` 
This script is only applicable if you use Google Chrome or Chromium browsers. 
Only argument of this script is the directory, where HttpDataReSender is located. Script will then perform steps descriped in the next section, except the work that has to be done with bulding and moving Daemons. It will only setup the manifest and paths.

## Manual setup

1. Copy the Native Messaging manifest into the correct location. What is the correct location can be found [here](https://developer.chrome.com/docs/apps/nativeMessaging/#native-messaging-host-location). Exact location may depend based on the browser that you use. These are the examples of the command for linux and macOS when using Google Chrome:
``` bash
# linux OS using Google Chrome
$ cp NativeMessagingHostsManifest/com.webtraffic.annotator.json ~/.config/google-chrome/NativeMessagingHosts/

# macOS using Google Chrome
$ cp NativeMessagingHostsManifest/com.webtraffic.annotator.json ~/Library/Application Support/Google/Chrome/NativeMessagingHosts/
``` 
1. Prepare the HttpDataReSender binary and other daemons and move it to the location where you want them to reside. In this step, we care most about the location of the HttpDataReSender as this must be specified in the manifest file that you just moved. When you know this location, substitute the string in the copied manifest like this: 
```
"path": "{SUBSTITUTE_THIS_FOR_A_PATH}\/HttpDataReSender",
----- will become
"path": "\/tmp\/dist\/bin\/HttpDataReSender",
```
1. When this is done, you can go to the Extension management page in your browser, turn on development mode and load this directory as an extension. 

If all these steps are successfully completed, you should see no error messages in the browser console. You can also check that HttpDataReSender has connected by checking output of the Joiner process. 
