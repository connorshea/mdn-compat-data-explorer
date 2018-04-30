function browserSupportParser() {
  // Returns an HTMLCollection
  let supportInfoElements = document.getElementsByClassName('browser-support-info');
  // console.log(supportInfoElements);

  for (var i = 0; i < supportInfoElements.length; i++) {
    let json = supportInfoElements.item(i).dataset.supportJson;
    let item = supportInfoElements.item(i);
    // console.log(json);
    if (json !== undefined) {
      parsedJson = JSON.parse(json);

      // If the JSON is an array, there are multiple
      // support objects that need to be parsed.
      if (Array.isArray(parsedJson)) {
        parseArraySupportObject(parsedJson, item);
      // Otherwise, the JSON is a hash and can be parsed
      // relatively simply.
      } else {
        parseHashSupportObject(parsedJson, item);
      }
    }
  };
}

function parseHashSupportObject(json, item) {
  jsonKeys = Object.keys(json);
  console.log(item);
  item.textContent = "butts";
  item.dataset.test = "butts";
  item.dataset.toggle = "popover";
  item.dataset.trigger = "focus";
  item.dataset.title = "More details";
  item.dataset.content = "details";

  console.log(json.version_added);
  console.log(json.alternative_name);

  possibleKeys = [
    "version_added",
    "version_removed",
    "flags",
    "notes",
    "prefix",
    "partial_implementation"
  ];
}

function parseArraySupportObject(json) {
  console.log(json);
}

ready(function () {
  browserSupportParser();
  $('body').popover({
    container: 'body',
    selector: '[data-toggle="popover"]'
  })
});
