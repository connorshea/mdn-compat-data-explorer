# MDN Browser Compat Data Explorer

This is a Rails app that lets the user explore the browser compatibility data that MDN is collecting in [the `mdn-browser-compat-data` repo](https://github.com/mdn/browser-compat-data).

This is a Work In Progress and may end up going nowhere, we'll see :)

Some ideas:

- See a list of features supported per-browser.
- Pie charts showing the status of features per browser, e.g. "40% of features are listed as supported in Chrome, 40% are listed as unsupported, and 20% are unknown".

## Running the application locally

You'll need:

- Postgres 9.6
- Ruby 2.5.x

Do the following:

1. `gem install bundler`
1. `bundle install`
1. `yarn install`
1. `rake db:create`
1. `rake db:migrate`
1. `bundle exec rails s`

With that, the site should be up at `localhost:3000`.

## Updating the data set

You can update the `mdn-browser-compat-data` package with `yarn upgrade`.

You can update `public/data.json` with new data from the npm package using `node lib/build.js`.
