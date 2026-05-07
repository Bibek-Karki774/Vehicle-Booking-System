const menuBtn = document.getElementById("menuBtn");
if (menuBtn) {
    const sidebar = document.querySelector(".sidebar");
    if (sidebar) {
        menuBtn.addEventListener("click", function () {
            sidebar.classList.toggle("open");
        });
    } else {
        const nav = document.getElementById("nav");
        menuBtn.addEventListener("click", function () {
            nav.classList.toggle("open");
            menuBtn.textContent = nav.classList.contains("open") ? "✖" : "☰";
        });
    }
}

function closeSidebar() {
    document.querySelector(".sidebar").classList.remove("open");
}