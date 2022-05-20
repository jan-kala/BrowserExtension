let nativeMessagingPort = null;
let requests = {}

function onSendHeadersCallback(details){
    // collect request data and save it under requestId key
    storageKey = details.requestId
    requests[storageKey] = details;


}

function onResponseStartedCallback(details){
    // cached content is not travelling through network
    if (details.fromCache == true){
        return;
    }

    url = new URL(details.url)

    // We don't care about other protocols
    if (url.protocol != "https:" && url.protocol != "http:"){
        return;
    }

    // in case of standart ports, field is empty
    let port;
    if (url.port == ''){
        if (url.protocol == "http:"){
            port = 80;
        } else if (url.protocol == "https:"){
            port = 443;
        }
    }

    // decide what IP version is being used
    let ip_version = 4;
    if (details.ip.includes(":")){
        ip_version = 6;
    }

    // Timestamp is in miliseconds and we need microseconds
    timeStamp = Math.trunc(details.timeStamp * 1000);

    storageKey = details.requestId;

    // Construct message
    message = {
        trigger: "onResponseStarted",
        hostname: url.hostname,
        proto: url.protocol,
        ipVersion: ip_version,
        ip: details.ip,
        port: port,
        timeStamp_s: timeStamp,
        timeStamp_ms: 0,
        details: {
            request: requests[storageKey],
            response: details
        }

    }

    // Log and send
    console.log(message)
    nativeMessagingPort.postMessage(message);
}

function errorOccured(details){
    message = {trigger: "error", details: details}
    console.log(message)
}
// communication backwards is not supported
const onNativeMessageReceived = (message) => {
    // console.log(message)
}

chrome.webRequest.onSendHeaders.addListener(
    onSendHeadersCallback,
    {urls: ["<all_urls>"]},
    ["requestHeaders"]
);

chrome.webRequest.onResponseStarted.addListener(
    onResponseStartedCallback,
    {urls: ["<all_urls>"]},
    ["responseHeaders"]
);
chrome.webRequest.onErrorOccurred.addListener(
    errorOccured,
    {urls: ["<all_urls>"]}
);

// Connect to the Native Message Host
nativeMessagingPort = chrome.runtime.connectNative("com.webtraffic.annotator");
nativeMessagingPort.onMessage.addListener(onNativeMessageReceived)

