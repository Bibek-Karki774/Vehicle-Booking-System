let icon = document.getElementById("profileIcon");
let panel = document.getElementById("profilePanel");

icon.onclick = function (event) {
    event.stopPropagation();
    panel.style.display = panel.style.display === "block" ? "none" : "block";
};

document.onclick = function () {
    panel.style.display = "none";
};