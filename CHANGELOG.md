# Changelog
All notable changes to this project will be documented in this file. Releases are created whenever the `master` branch is deployed to Heroku.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]
### Added
- Describe the application on the home page.
- Create a page for each browser, list all new features for each release. ([#41])
- Random sorting option for the features page. ([#42])
- Keep a `CHANGELOG.md`. ([#45])
- Display Travis CI badge in `README.md`. ([#47])
- Add a 404 checker for MDN URLs, currently this is run manually and not saved or exposed in the application. ([#48])
- Add filtering by browser status (e.g. filter down to features where Firefox is exactly `true` or where Chrome has no data) to the search page. ([#51])

### Fixed
- Correctly handle `version_removed` property for the browser support tables. ([#43])

## [0.3.1] - 2018-05-04
### Added
- Google Analytics tracking. ([#40])

### Fixed
- Minor README cleanups.

## [0.3.0] - 2018-05-03
### Added
- Render popovers for support objects with more information than just `version_added`. ([#27], [#28])
- Properly render partial support in feature support tables.
- Search filters for MDN URLs, descriptions, and experimental/deprecated/standard track info. ([#29])

### Changed
- Move search filters to the left sidebar on desktop. ([#30])
- Upgrade the dataset to `0.0.34`. ([#31])

## [0.2.0] - 2018-04-28
### Added
- Use `annotate` gem to provide database information in model files. ([#23])
- Use `rails-erd` gem to visualize the database setup. ([#24])
- Use `better-errors` gem to replace Rails' crappy default error pages.
- A Graphs page with donut graphs for each browser and its respective coverage of features in the dataset. ([#12])
- Support for using test data by setting `USE_TEST_DATA=true` when running `rake db:seed`.
- Use `factory-bot` gem and update the test suite to use it. ([#26])
- Tests of feature scope accuracy for the graphs page.

## [0.1.3] - 2018-04-26
### Fixed
- Fix DatabaseCleaner not running in production. This caused the Heroku deployment to fail for v0.1.2. Normally it'd be crazy to run DatabaseCleaner on a production database, but this is a static dataset so it's fine.

## [0.1.2] - 2018-04-26
### Added
- Write a bunch of tests for the test suite.
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

[#12]: https://github.com/connorshea/mdn-compat-data-explorer/pull/12
[#23]: https://github.com/connorshea/mdn-compat-data-explorer/pull/23
[#24]: https://github.com/connorshea/mdn-compat-data-explorer/pull/24
[#26]: https://github.com/connorshea/mdn-compat-data-explorer/pull/26
[#27]: https://github.com/connorshea/mdn-compat-data-explorer/pull/27
[#28]: https://github.com/connorshea/mdn-compat-data-explorer/pull/28
[#29]: https://github.com/connorshea/mdn-compat-data-explorer/pull/29
[#31]: https://github.com/connorshea/mdn-compat-data-explorer/pull/31
[#40]: https://github.com/connorshea/mdn-compat-data-explorer/pull/40
[#41]: https://github.com/connorshea/mdn-compat-data-explorer/pull/41
[#42]: https://github.com/connorshea/mdn-compat-data-explorer/pull/42
[#43]: https://github.com/connorshea/mdn-compat-data-explorer/pull/43
[#45]: https://github.com/connorshea/mdn-compat-data-explorer/pull/45
[#47]: https://github.com/connorshea/mdn-compat-data-explorer/pull/47
[#48]: https://github.com/connorshea/mdn-compat-data-explorer/pull/48
[#51]: https://github.com/connorshea/mdn-compat-data-explorer/pull/51

[Unreleased]: https://github.com/olivierlacan/keep-a-changelog/compare/v0.3.1...HEAD
[0.3.1]: https://github.com/connorshea/mdn-compat-data-explorer/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/connorshea/mdn-compat-data-explorer/compare/v0.2.1....v0.3.0
[0.2.1]: https://github.com/connorshea/mdn-compat-data-explorer/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/connorshea/mdn-compat-data-explorer/compare/v0.1.3...v0.2.0
[0.1.3]: https://github.com/connorshea/mdn-compat-data-explorer/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/connorshea/mdn-compat-data-explorer/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/connorshea/mdn-compat-data-explorer/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/connorshea/mdn-compat-data-explorer/compare/ee9ba623834b8872fc7f6dac97f0197cf29c311b...v0.1.0
