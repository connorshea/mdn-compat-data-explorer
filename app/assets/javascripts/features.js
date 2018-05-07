function browserSupportParser() {
  // Returns an HTMLCollection
  let supportInfoElements = document.getElementsByClassName('browser-support-info');

  for (var i = 0; i < supportInfoElements.length; i++) {
    let json = supportInfoElements.item(i).dataset.supportJson;
    let item = supportInfoElements.item(i);
    // console.log(json);
    if (json !== undefined) {
      parsedJson = JSON.parse(json);

      // If the JSON is an array of length > 1, there are multiple
      // support objects that need to be parsed.
      if (Array.isArray(parsedJson) && parsedJson.length > 1) {
        parseArraySupportObject(parsedJson, item);
      // Otherwise, the JSON is a hash and can be parsed
      // relatively simply.
      } else {
        item.dataset.content = parseHashSupportObject(parsedJson[0], item);
      }
    }
  };
}

function parseHashSupportObject(json, item, partOfArray = false) {
  // Return early if JSON is null.
  if (json == null) { return; }

  jsonKeys = Object.keys(json);
  if (jsonKeys.length > 1 || partOfArray) {
    item.dataset.toggle = "popover";
    item.classList.add('more-info-available');
  } else {
    return;
  }

  item.dataset.title = "More details";

  let contentForPopover = new Map();

  let versionInfo = '';

  if (!json) {
    versionInfo += getVersionString(null);
  } else {
    versionInfo += getVersionString(json.version_added);
  }

  if (json.version_removed) {
    // We don't know when
    if (typeof (json.version_removed) === 'boolean' && json.version_removed) {
      versionInfo += '&nbsp;—?'
    } else { // We know when
      versionInfo += '&nbsp;— ' + json.version_removed;
    }
  }

  contentForPopover.set("version_added", `<b>${versionInfo}</b>`);

  if (jsonKeys.includes('partial_implementation')) {
    contentForPopover.set("partial_implementation", "This is a partial implementation.");
  }

  if (jsonKeys.includes('notes')) {
    if (Array.isArray(json.notes)) {
      contentForPopover.set("notes", `Notes: ${json.notes.join("<br>")}`);
    } else {
      contentForPopover.set("notes", `Notes: ${json.notes}`);
    }
  }
  
  if (jsonKeys.includes('alternative_name')) {
    contentForPopover.set("alternative_name", `Supported as: <code>${json.alternative_name}</code>`);
  }

  if (jsonKeys.includes('prefix')) {
    contentForPopover.set("prefix", `Requires the vendor prefix: <code>${json.prefix}</code>`);
  }

  // From https://github.com/mdn/kumascript/blob/1b392341c2835e8e73bba8471160c1349f2838dc/macros/Compat.ejs#L188-L263
  if (jsonKeys.includes('flags')) {
    let output = '';

    if (typeof (json.version_added) === 'string') {
      output = `From version ${json.version_added}`;
    }
    if (typeof (json.version_removed) === 'string') {
      if (output) {
        output += ' ';
        output += `until version ${json.version_removed} (exclusive)`;
      } else {
        output = `Until version ${json.version_removed} (exclusive)`;
      }
    }

    let start = 'This';
    if (output) {
      output += ':';
      start = ' this';
    }

    start += ' feature is behind the ';
    let flagsText = '';
    let settings = '';

    for (i = 0; i < json.flags.length; i++) {
      let flag = json.flags[i];
      let nameString = `<code>${flag.name}</code>`;
      // value_to_set is optional
      let valueToSet = '';
      if (flag.value_to_set) {
        valueToSet = ` (needs to be set to <code>${flag.value_to_set}</code>)`;
      }
      let typeString = '';
      if (flag.type === 'preference') {
        typeString = ` preference${valueToSet}`;
      }
      if (flag.type === 'compile_flag') {
        typeString = ` compile flag${valueToSet}`;
      }
      if (flag.type === 'runtime_flag') {
        typeString = ` runtime flag${valueToSet}`;
      }
      flagsText += nameString + typeString;
      if (i != json.flags.length - 1) {
        flagsText += ' and the ';
      } else {
        flagsText += '.';
      }
    }
    output += start + flagsText;

    contentForPopover.set("flags", output);
  }

  if (!partOfArray && jsonKeys.includes('version_removed')) {
    contentForPopover.set("version_removed", `Version removed: ${json.version_removed}`);
  }

  contentForPopoverHtml = "";
  for (var [key, value] of contentForPopover.entries()) {
    contentForPopoverHtml += `<p>${value}</p>`;
  }

  return contentForPopoverHtml;
}

function parseArraySupportObject(json, item) {
  itemContent = '';

  for (var i = 0; i < json.length; i++) {
    itemContent += parseHashSupportObject(json[i], item, true);
  }

  item.dataset.content = itemContent;
}

// From https://github.com/mdn/kumascript/blob/1b392341c2835e8e73bba8471160c1349f2838dc/macros/Compat.ejs#L126-L143
function getVersionString(versionInfo) {
  switch (versionInfo) {
    case null:
      return `<span title="Unknown">Unknown</span>`;
      break;
    case true:
      return `<span title="Yes">Yes</span>`;
      break;
    case false:
      return `<span title="No">No</span>`;
      break;
    default:
      return versionInfo;
  }
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
