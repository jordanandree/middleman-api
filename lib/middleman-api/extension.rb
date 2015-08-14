require "active_support/core_ext"

# Extension namespace
module Middleman::Api
  class Extension < ::Middleman::Extension

    # Support for .json and .xml
    option :formats, [:json, :xml]

    # Specific paths to render as :formats
    option :paths, []

    # ignore metadata keys
    option :ignore_metadata_keys, []

    def after_configuration
      # Hack to reload our templates dir into the FileWatcher API
      # https://github.com/middleman/middleman/issues/1217#issuecomment-38014250
      fix_templates_for_filewatcher!
      app.ignore "__api/*"
    end

    def manipulate_resource_list(resources)
      new_resources = []

      options.formats.each do |format|
        proxy_parent = ::Middleman::Sitemap::Resource.new(
          app.sitemap, "__api/proxy.#{format}", fetch_template)
        proxy_parent.add_metadata locals: { resource_data: nil }

        new_resources << proxy_parent

        resources.each do |resource|
          ext = resource.ext.gsub('.','').to_sym

          next if resource.ignored? || ext == format
          next if Middleman::Util.path_match(app.images_dir, resource.path)
          next if Middleman::Util.path_match(app.js_dir, resource.path)
          next if Middleman::Util.path_match(app.css_dir, resource.path)
          next if Middleman::Util.path_match(app.fonts_dir, resource.path)
          next unless resource.template?
          next if options.paths.any? && !matches_include_paths?(resource.path)

          new_resources << add_proxy_for_format(resource, format)
        end
      end

      return resources + new_resources
    end

    private

      def matches_include_paths?(resource_path)
        options.paths.each do |path|
          next unless resource_path =~ %r[^#{path}]
          return true; break
        end
        return false
      end

      def fix_templates_for_filewatcher!
        extension_templates_dir = File.expand_path('../', __FILE__)
        templates_dir_relative_from_root = Pathname(extension_templates_dir)
          .relative_path_from(Pathname(app.root))
        app.files.reload_path(templates_dir_relative_from_root)
      end

      def add_proxy_for_format(resource, format)
        if resource.url == '/' || !(resource.path =~ /index\.html$/)
          path_base = "#{resource.destination_path.split('.').first}"
        else
          path_base = "#{resource.destination_path.split('/')[0..-2].join('/')}"
        end

        if @app.extensions.include?(:directory_indexes)
          path_base.gsub!("/index", "")
        end

        path = "#{path_base}.#{format}"

        proxy = ::Middleman::Sitemap::Resource.new(
          app.sitemap, path, fetch_template)
        proxy.add_metadata locals: template_data(resource, format)
        proxy.add_metadata options: { layout: false }
        proxy.proxy_to "__api/proxy.#{format}"

        return proxy
      end

      # Resource data hash
      # @return [Hash] resource data to be parsed into json
      def template_data(resource, format)
        data = {}
        meta = resource.data.select { |k,v| !options.ignore_metadata_keys.include?(k) }
        data[:resource_data] = {
          meta:    meta,
          path:    resource.url,
          content: resource.render
        }.send("to_#{format}")

        return data
      end

      def fetch_template
        File.expand_path("../template.erb", __FILE__)
      end

    ::Middleman::Extensions.register(:api, Middleman::Api::Extension)
  end
end
