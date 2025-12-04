const selectElement = document.getElementById('zversion');

selectElement.addEventListener('change', function() {
    const version = selectElement.value;    
    window.location.pathname = "/" + version + "/index.html";
});
