// iframe.js
window.onload = function () {
    var iframe = document.getElementById("my-iframe");
    // Get the hostname of the current (parent) window
    var parentHostname = window.location.hostname; // Get IP Address or Hostname

    var portainerUrl = "https://" + parentHostname + ":9443/";

    iframe.src = portainerUrl;
};

function openSource() {
    // Retrieve the URL from the iframe
    var iframe = document.getElementById("my-iframe");
    var iframeUrl = iframe.src;

    // Open the source URL in a new tab or window
    window.open(iframeUrl, '_blank');
}
