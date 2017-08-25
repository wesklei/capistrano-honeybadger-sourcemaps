# Capistrano Honeybadger Sourcemaps

Uploads sourcemaps for your application as a part of the Capistrano deploy
process. See the [Honeybadger docs](https://docs.honeybadger.io/guides/source-maps.html) for more
information on source map support in Honeybadger.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-honeybadger-sourcemaps'
```

And then execute:

    $ bundle

## Usage

In your `Capfile`:

```ruby
require 'capistrano/honeybadger/sourcemaps'
```

The task will run after `deploy:set_current_revision` by default

## Configurable options

### Required

```ruby
# For generating the minified_url that is passed to honeybadger on upload
set :honeybadger_sourcemaps_minified_url_base, 'http://www.example.com'

# Directory that will be searched for source maps to upload
set :honeybadger_sourcemaps_target_dir, './cache/my_app'

# Role under which sourcemaps should be uploaded
set :honeybadger_sourcemaps_role, :sourcemaps
```

### Optional
```ruby
# honeybadger api key. Defaults to the honeybadger_api_key used by the honeybadger gem
set :honeybadger_sourcemaps_api_key, -> { fetch :honeybadger_api_key }

# Version of the sourcemaps for honeybadger. Uses the current_revision by default
set :honeybadger_sourcemaps_version, -> { fetch :current_revision }

# Glob pattern used to search for sourcemaps in the target_dir
set :honeybadger_sourcemaps_glob_pattern, File.join('**', '*.js.map')

# Gsub pattern used to convert a sourcemap file to the associated JS file
set :honeybadger_sourcemaps_gsub_pattern, /\.map\Z/
```
