function browserSupportParser() {
  // Returns an HTMLCollection
  let supportInfoElements = document.getElementsByClassName('browser-support-info');

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
  if (jsonKeys.length > 1) {
    item.dataset.toggle = "popover";
  } else {
    return;
  }

  item.dataset.title = "More details";

  let contentForPopover = new Map();

  if (jsonKeys.includes('partial_implementation')) {
    contentForPopover.set("Partial implementation", "This is a partial implementation.");
  }

  if (jsonKeys.includes('notes')) {
    if (Array.isArray(json.notes)) {
      contentForPopover.set("Notes", json.notes.join("<br>"));
    } else {
      contentForPopover.set("Notes", json.notes);
    }
  }
  
  if (jsonKeys.includes('alternative_name')) {
    contentForPopover.set("Alternative Name", json.alternative_name);
  }

  if (jsonKeys.includes('prefix')) {
    contentForPopover.set("Requires the vendor prefix", "<code>" + json.prefix + "</code>");
  }

  contentForPopoverHtml = "";
  for (var [key, value] of contentForPopover.entries()) {
    contentForPopoverHtml += '<p>' + key + ': ' + value + '</p>';
  }

  item.dataset.content = contentForPopoverHtml;
}

function parseArraySupportObject(json) {
  console.log(json);
}

ready(function () {
  browserSupportParser();
  $('body').popover({
    container: 'body',
    html: true,
    selector: '[data-toggle="popover"]',
    template: '<div class="popover" role="tooltip"> <div class="arrow"></div> <h3 class="popover-header"></h3> <div class="popover-body"></div></div>'
  })
});
