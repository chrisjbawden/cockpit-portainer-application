window.onload = function () {
    const iframe = document.getElementById("my-iframe");
    const errorDiv = document.getElementById("error-message");

    cockpit.spawn(["hostname", "-I"]).stream(function (data) {
        const hostIP = data.trim().split(' ')[0];
        const url = "https://" + hostIP + ":9443/";

        iframe.src = url;

        // Build error message with dynamic link
        errorDiv.innerHTML = `
            <div>
                <strong>Unable to load Portainer.</strong><br><br>
                This may be due to an untrusted SSL certificate.<br>
                Please open <a href="${url}" target="_blank">${url}</a> in a new tab,<br>
                accept the browser security warning, and then refresh this page.
            </div>
        `;

        // Try to fetch the endpoint to verify reachability
        fetch(url, { method: 'HEAD', mode: 'no-cors' })
            .then(() => {
                iframe.style.zIndex = 2;
                errorDiv.style.display = "none";
            })
            .catch(() => {
                iframe.style.zIndex = 0;
                errorDiv.style.display = "flex";
            });
    });

    // Inactivity refresh logic (30 minutes)
    let refreshTimeout;

    function resetInactivityTimer() {
        clearTimeout(refreshTimeout);
        refreshTimeout = setTimeout(() => {
            console.log("Inactivity detected: refreshing page.");
            location.reload();
        }, 30 * 60 * 1000); // 30 minutes
    }

    // Detect common activity types
    ["mousemove", "keydown", "mousedown", "touchstart"].forEach(event => {
        document.addEventListener(event, resetInactivityTimer);
    });

    // Start the timer initially
    resetInactivityTimer();
};

function openSource() {
    const iframe = document.getElementById("my-iframe");
    window.open(iframe.src, '_blank');
}
