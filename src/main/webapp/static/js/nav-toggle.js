function openSidebar() {
    document.querySelector(".sidebar").classList.add("open");
}

function closeSidebar() {
    document.querySelector(".sidebar").classList.remove("open");
}

function toggleTopNav() {
    const nav = document.getElementById("nav");
    const btn = document.getElementById("menuBtn");
    nav.classList.toggle("open");
    btn.textContent = nav.classList.contains("open") ? "✖" : "☰";
}