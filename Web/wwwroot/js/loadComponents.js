document.addEventListener('DOMContentLoaded', function() {
    // Load header
    fetch('components/header.html')
        .then(response => response.text())
        .then(data => {
            document.body.insertAdjacentHTML('afterbegin', data);
        });

    // Load footer
    fetch('components/footer.html')
        .then(response => response.text())
        .then(data => {
            document.body.insertAdjacentHTML('beforeend', data);
        });
});



    document.getElementById('themeToggle').addEventListener('click', function() {
        document.body.classList.toggle('light-mode');
        const isDark = !document.body.classList.contains('light-mode');
        
        // Update colors based on theme
        if (isDark) {
            document.body.style.backgroundColor = '#212529';
            document.body.style.color = '#fff';
        } else {
            document.body.style.backgroundColor = '#f8f9fa';
            document.body.style.color = '#212529';
        }
    });
