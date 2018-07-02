// From https://github.com/eduardoboucas/compat-report/blob/master/pre-build/build-data.js
// Licensed under the ISC License.
const compatData = require('mdn-browser-compat-data')
const fs = require('fs')
const path = require('path')

// const payload = {
//   api: compatData.api,
//   browsers: compatData.browsers,
//   css: compatData.css,
//   html: compatData.html,
//   http: compatData.http,
//   javascript: compatData.javascript,
//   mathml: compatData.mathml,
//   svg: compatData.svg,
//   webdriver: compatData.webdriver,
//   webextensions: compatData.webextensions
// }

const payload = {
  api: compatData.api,
  browsers: compatData.browsers,
  css: compatData.css,
  html: compatData.html,
  http: compatData.http,
  javascript: compatData.javascript,
  mathml: compatData.mathml,
  svg: compatData.svg,
  webdriver: compatData.webdriver,
  webextensions: compatData.webextensions
}

fs.writeFile(
  path.resolve(
    __dirname,
    '..',
    'public',
    'data.json'
  ),
  JSON.stringify(payload, null, 2),
  err => {
    if (err) {
      console.error(err)
    }
  }
)
