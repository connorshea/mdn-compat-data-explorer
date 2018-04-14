# MDN Browser Compatability Data Explorer

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

## Notes

- [Using PostgreSQL and jsonb with Ruby on Rails](https://nandovieira.com/using-postgresql-and-jsonb-with-ruby-on-rails) is a really useful article for understanding jsonb usage with Postgres and Rails (this is used in this app). 

### Dependencies

This project uses:

- [Ruby on Rails](http://rubyonrails.org/)
- [Bourbon](https://www.bourbon.io/)
- [Bitters](https://bitters.bourbon.io/)
- [Mozilla Developer Network Browser Compatability Data](https://github.com/mdn/browser-compat-data)

To view all dependencies used in this project, see the [`Gemfile`](/Gemfile) and [`package.json`](package.json).

### TODO

- Figure out how to use the [version_sorter](https://github.com/github/version_sorter) gem for determing browser support, and possibly for sorting the browser version tables.
- Remove ActionCable (and ActiveStorage?) since they're unnecessary for the project.
