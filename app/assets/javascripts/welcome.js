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
  // Only run the function if the element exists, this way there's no
  // failure in the production environment where the JSON isn't sent to the
  // client.
  if (document.getElementById('data-json-location') !== null) {
    getJsonLocation();
  }
};
