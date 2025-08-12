const selectElement = document.getElementById('zversion');

selectElement.addEventListener('change', function() {
    const version = selectElement.value;    
    window.location.pathname = "{{ eval baseURL }}/" + version + "/index.html";
});
