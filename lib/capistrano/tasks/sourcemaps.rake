require 'net/http/post/multipart'

namespace :honeybadger do
  namespace :sourcemaps do
    def upload_sourcemap(s_map)
      debug "Uploading sourcemap #{s_map}"

      uri = URI.parse('https://api.honeybadger.io/v1/source_maps')
      req = Net::HTTP::Post::Multipart.new uri.path,
        'api_key' => fetch(:honeybadger_sourcemaps_api_key),
        'minified_url' => minified_url_for(js_filename(s_map)),
        'minified_file' => UploadIO.new(File.new(js_filename(s_map)), "application/octet-stream"),
        'source_map' => UploadIO.new(File.new(s_map), "application/octet-stream"),
        'revision' => fetch(:honeybadger_sourcemaps_version)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      res = http.request(req)

      begin
        res.value
      rescue
        info "Failed to upload sourcemap for #{s_map}. Error was #{res.code}: #{res.msg}"
      end
    end

    def js_filename(s_map)
      gsub_pattern = fetch(:honeybadger_sourcemaps_gsub_pattern)
      s_map.gsub(gsub_pattern, '')
    end

    def minified_url_for(s_map)
      url_base = fetch(:honeybadger_sourcemaps_minified_url_base).dup
      url_base = url_base.prepend('http://') unless url_base.index(/https?:\/\//)

      url = "#{File.join(url_base, js_filename(s_map))}*"
      debug "Minified url for #{s_map}: #{url}"
      url
    end

    desc 'Upload sourcemaps to honeybadger'
    task :upload do
      on roles fetch(:honeybadger_sourcemaps_role) do
        debug "Uploading source maps from #{fetch(:honeybadger_sourcemaps_target_dir)}"
        Dir.chdir fetch(:honeybadger_sourcemaps_target_dir) do
          Dir.glob(fetch(:honeybadger_sourcemaps_glob_pattern)).each do |s_map|
            upload_sourcemap(s_map)
          end
        end
      end
    end
  end
end
