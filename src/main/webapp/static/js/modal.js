function openModal(btn) {
    // Set vehicle id in hidden input
    document.getElementById('modal-vehicle-id').value = btn.getAttribute('data-vehicleId');
    document.getElementById('modal').style.display = 'flex';
    document.body.style.overflow = 'hidden';

    // Get today and max date (today + 6 days)
    const today = new Date();
    const maxDate = new Date();
    maxDate.setDate(today.getDate() + 6);

    // Convert date to YYYY-MM-DD format for input
    const toLocalDate = (d) => d.toISOString().split('T')[0];

    // Block past dates and dates beyond 7 days
    document.getElementById('fromDate').min = toLocalDate(today);
    document.getElementById('fromDate').max = toLocalDate(maxDate);
    document.getElementById('toDate').min   = toLocalDate(today);
    document.getElementById('toDate').max   = toLocalDate(maxDate);

    // Clear previous values on every open
    document.getElementById('fromDate').value = '';
    document.getElementById('toDate').value   = '';
}

function closeModal() {
    document.getElementById('modal').style.display = 'none';
    document.body.style.overflow = '';

    // Clear available dates section when modal is closed
    document.getElementById('available-dates-section').style.display = 'none';
}

window.addEventListener('click', function (e) {
    if (e.target === document.getElementById('modal')) closeModal();
});