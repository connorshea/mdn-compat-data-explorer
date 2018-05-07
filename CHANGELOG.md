# Changelog
All notable changes to this project will be documented in this file. Releases are created whenever the `master` branch is deployed to Heroku.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]
### Added
- Add descriptive text to the home page.
- Add a page for each browser, list all new features for each release. (#41)
- Add random sorting for the features page. (#42)
- Add a `CHANGELOG.md`. (#45)

### Fixed
- Correctly handle `version_removed` property for the browser support tables. (#43)

## [0.3.1] - 2018-05-04
### Added
- Add Google Analytics tracking.

### Fixed
- Minor README cleanups.

## [0.3.0] - 2018-05-03
### Added
- Render popovers for support objects with more information than just `version_added`. (#27, #28)
- Properly render partial support in feature support tables.
- Add search filters for MDN URLs, descriptions, and experimental/deprecated/standard track info. (#29)

### Changed
- Move search filters to the left sidebar on desktop. (#30)
- Upgrade the dataset to `0.0.34`. (#31)

## [0.2.0] - 2018-04-28
### Added
- Add `annotate` gem to provide database information in model files. (#23)
- Add `rails-erd` gem to visualize the database setup. (#24)
- Add `better-errors` gem to replace Rails' crappy default error pages.
- Add a Graphs page with donut graphs for each browser and its respective coverage of features in the dataset. (#12)
- Add support for using test data by setting `USE_TEST_DATA=true` when running `rake db:seed`.
- Add `factory-bot` gem and update the test suite to use it. (#26)
- Add tests of feature scope accuracy for the graphs page.

## [0.1.3] - 2018-04-26
### Fixed
- Fix DatabaseCleaner not running in production. This caused the Heroku deployment to fail for v0.1.2. Normally it'd be crazy to run DatabaseCleaner on a production database, but this is a static dataset so it's fine.

## [0.1.2] - 2018-04-26
### Added
- Add a bunch of tests to the test suite.
- Create a `data-test.json` file for use with the test suite.

### Changed
- Update the `mdn-browser-compat-data` package to `0.0.33`.

## [0.1.1] - 2018-04-24
### Changed
- The footer now displays a version number for the MDN BCD package as well as a link to its GitHub release page.
- A minor improvement to the header on smaller screens.

## [0.1.0] - 2018-04-24

First tagged release, includes some basic functionality.

### Added
- Responsive design.
- View some simple data from the BCD repo.
- View browser data with versions, release dates, and release notes.
- Search, includes text search by name and filtering by feature category.
- Feature cards for each feature tracked in the BCD, includes info like browser support info (currently somewhat inaccurate), description, MDN links, and deprecation/experimental/standard track info.
