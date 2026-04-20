let icon = document.getElementById("profileIcon");
let panel = document.getElementById("profilePanel");

icon.onclick = function () {
    if (panel.style.display == "block") {
        panel.style.display = "none";
    } else {
        panel.style.display = "block";
    }
};

// click anywhere in page
document.onclick = function () {
    panel.style.display = "none";
};

// stop closing when clicking icon
icon.onclick = function (event) {
    event.stopPropagation();

    if (panel.style.display == "block") {
        panel.style.display = "none";
    } else {
        panel.style.display = "block";
    }
};