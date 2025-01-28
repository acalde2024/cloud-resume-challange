const counter = document.querySelector(".counter-number");
async function updateCounter() {
    let response = await fetch("https://o2a3wizh775shoai4uqsntdhju0cflyc.lambda-url.us-east-2.on.aws/");
    let data = await response.json();
    counter.innerHTML = ' Views: ' + data;
}

updateCounter();