# MDN Browser Compatability Data Explorer

This is a Rails app that lets the user explore the browser compatibility data that MDN is collecting in [the `mdn-browser-compat-data` repo](https://github.com/mdn/browser-compat-data).

This is a Work In Progress and may end up going nowhere, we'll see :)

Some ideas:

- See a list of features supported per-browser.
- Pie charts showing the status of features per browser, e.g. "40% of features are listed as supported in Chrome, 40% are listed as unsupported, and 20% are unknown".

## Development
### Running the application locally

You'll need:

- Postgres 9.6
- Ruby 2.5.x

Run the following commands:

1. `gem install bundler`
1. `bundle install`
1. `yarn install`
1. `rake db:create`
1. `rake db:migrate`
1. `bundle exec rails s`

With that, the site should be up at `localhost:3000`.

### Updating the data.json

You can update the `mdn-browser-compat-data` package with `yarn upgrade`.

You can update `public/data.json` with new data from the npm package using
`node lib/build.js`.

### Updating the database

You can update the database (where all the data is stored) by running
`rake db:seed`. Note that this will delete the database and fill it with
whatever data is in `public/data.json` based on `db/seeds.rb`.

The application essentially uses a static data set. It uses a database
simply because I wanted to learn more about databases and wanted an easier
means of querying the data.

### Deployment

The live site currently uses Heroku, and is available at [mdn-compat-data-explorer.herokuapp.com](https://mdn-compat-data-explorer.herokuapp.com/).

Deployment involves the following:

- Deploy the current version of the `master` branch.
- Run `bundle exec rake db:migrate` and `bundle exec rake db:seed` from the [Heroku Web Console](https://devcenter.heroku.com/articles/heroku-dashboard#web-console) or with the Heroku CLI.

This should update the site to the current codebase and recreate the database from the `db/seeds.rb` file.

### Dependencies

This project uses:

- [Ruby on Rails 5.2](http://rubyonrails.org/)
- [Bootstrap 4.1](http://getbootstrap.com/)
- [Mozilla Developer Network Browser Compatability Data](https://github.com/mdn/browser-compat-data)
- [Octicons](https://octicons.github.com/)

To view all dependencies used in this project, see the [`Gemfile`](/Gemfile) and [`package.json`](package.json).

## Notes

### Resources

- [Using PostgreSQL and jsonb with Ruby on Rails](https://nandovieira.com/using-postgresql-and-jsonb-with-ruby-on-rails) is a really useful article for understanding jsonb usage with Postgres and Rails (this is used in this app). 

### TODO

- Add a timeline of browser releases.
- Implement visualizations using the dataset.
- Implement caching, the data is static so this should be fairly easy (famous last words).
- Improve the feature table's readability.
- Expose the dataset version somewhere in the interface (the footer?).
- Write some tests.
- Figure out how to handle data for the browser when there's more than one `version_added` statement, or when there are `flags` or `notes`.
