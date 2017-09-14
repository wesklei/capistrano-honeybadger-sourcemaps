load File.expand_path('../../tasks/sourcemaps.rake', __FILE__)

namespace :deploy do
  after 'deploy:published', 'honeybadger:sourcemaps:upload'
end

namespace :load do
  task :defaults do
    load "capistrano/honeybadger/sourcemaps/defaults.rb"
  end
end
