function browserSupportParser() {
  // Returns an HTMLCollection
  let supportInfoElements = document.getElementsByClassName('browser-support-info');
  console.log(supportInfoElements);

  for (var i = 0; i < supportInfoElements.length; i++) {
    let json = supportInfoElements.item(i).dataset.supportJson
    console.log(json);
    if (json === undefined) {
      console.log("undefined JSON");
    } else {
      JSON.parse(supportInfoElements.item(i).dataset.supportJson);
    }
  };
}

ready(function () {
  browserSupportParser();
});
