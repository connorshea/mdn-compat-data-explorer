function getJsonLocation() {
  let jsonLocation = document.getElementById('data-json-location').dataset.jsonLocation;

  fetch(jsonLocation)
    .then(res => res.json())
    .then((out) => {
      console.log(out);
    })
    .catch(err => { throw err });
}

window.onload = function() { 
  getJsonLocation();
};
