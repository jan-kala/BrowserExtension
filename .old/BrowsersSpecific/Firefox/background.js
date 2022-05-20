let port = null;

function sendDataToSysProcess(details){
    console.log(details)

    // message = {message: details}
    // port.postMessage(message);
}

async function logSubject(details) {
    try {
      let securityInfo = await browser.webRequest.getSecurityInfo(details.requestId, {});
      message = {data: details, secInfo: securityInfo}
      console.log(message);
    }
    catch(error) {
      console.error(error);
    }
  }

const onNativeMessageReceived = (message) => {
    // console.log(message)
}

// chrome.webRequest.onSendHeaders.addListener(
//     sendDataToSysProcess,
//     {urls: ["<all_urls>"]}
// );
browser.webRequest.onHeadersReceived.addListener(
    logSubject,
    {urls: ["<all_urls>"]},
    ["blocking"]
);

// Connect to the Native Message Host
// port = chrome.runtime.connectNative("com.kala.annotator");
// port.onMessage.addListener(onNativeMessageReceived)