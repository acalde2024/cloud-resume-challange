const counter = document.querySelector(".counter-number");
async function updateCounter() {
    let response = await fetch("type your HTTPS://your-lambda-url-here");
    let data = await response.json();
    counter.innerHTML = ' Views: ' + data;
}

updateCounter();