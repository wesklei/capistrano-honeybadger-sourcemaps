# For generating the minified_url that is passed to honeybadger on upload
set :honeybadger_sourcemaps_minified_url_base, -> { abort 'Please specify the minified URL for your minified javascript' }

# Directory that will be searched for source maps to upload
set :honeybadger_sourcemaps_target_dir, -> { abort 'Please specify the directory from which your javascript sourcemaps will be uploaded'}

# Role under which sourcemaps should be uploaded
set :honeybadger_sourcemaps_role, -> { abort 'Please specify the role from which your javascript sourcemaps will be uploaded' }

# honeybadger token. Defaults to the honeybadger_api_key used by the honeybadger gem
set :honeybadger_sourcemaps_api_key, -> { fetch :honeybadger_api_key }

# Version of the sourcemaps for honeybadger. Uses the current_revision by default
set :honeybadger_sourcemaps_version, -> { fetch :current_revision }

# Glob pattern used to search for sourcemaps in the target_dir
set :honeybadger_sourcemaps_glob_pattern, File.join('**', '*.js.map')

# Gsub pattern used to convert a sourcemap file to the associated JS file
set :honeybadger_sourcemaps_gsub_pattern, /\.map\Z/
