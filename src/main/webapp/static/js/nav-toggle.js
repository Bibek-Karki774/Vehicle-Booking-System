// Js code too toggle mobile nav bar
function toggleMenu() {
    const nav = document.getElementById("nav");
    const btn = document.getElementById("menuBtn");

    nav.classList.toggle("open");

    // change icon
    if (nav.classList.contains("open")) {
        btn.innerHTML = "✖";
    } else {
        btn.innerHTML = "☰";
    }
}