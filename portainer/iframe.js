// iframe.js
window.onload = function () {
    var iframe = document.getElementById("my-iframe");

    cockpit.spawn(["hostname", "-I"]).stream(function (data) {
        var hostIP = data.trim().split(' ')[0]; // Extract the first IP address
        var url = "https://" + hostIP + ":9443/";


        iframe.src = url;
    });
};

function openSource() {
    // Retrieve the URL from the iframe
    var iframe = document.getElementById("my-iframe");
    var iframeUrl = iframe.src;

    // Open the source URL in a new tab or window
    window.open(iframeUrl, '_blank');
}