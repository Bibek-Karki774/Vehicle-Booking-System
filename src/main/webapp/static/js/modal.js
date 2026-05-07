function openModal(btn) {
    document.getElementById('modal-vehicle-id').value = btn.getAttribute('data-vehicleId');
    document.getElementById('modal').style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

function closeModal() {
    document.getElementById('modal').style.display = 'none';
    document.body.style.overflow = '';
}

window.addEventListener('click', function (e) {
    if (e.target === document.getElementById('modal')) closeModal();
});