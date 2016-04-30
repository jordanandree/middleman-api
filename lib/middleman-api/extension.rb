require 'active_support'
require 'active_support/core_ext'

# Extension namespace
module Middleman
  module Api
    class Extension < ::Middleman::Extension

      # Support for .json and .xml
      option :formats, [:json, :xml]

      # Specific paths to render as :formats
      option :paths, []

      # ignore metadata keys
      option :ignore_metadata_keys, []

      # Path to custom template (should probably be ERB)
      option :template, nil

      def after_configuration
        app.ignore '__api/*'
        app.ignore options.template if options.template
      end

      def manipulate_resource_list resources
        new_resources = []

        options.formats.each do |format|
          proxy_parent = ::Middleman::Sitemap::Resource.new(
            app.sitemap, "__api/proxy.#{format}", fetch_template)
          proxy_parent.add_metadata locals: { resource_data: nil }

          new_resources << proxy_parent

          resources.each do |resource|
            ext = resource.ext.delete('.').to_sym

            next if options.paths.any? && !matches_include_paths?(resource)
            next if resource.ignored? || ext == format
            next if should_ignore_resource?(resource)

            new_resources << add_proxy_for_format(resource, format)
          end
        end

        resources + new_resources
      end

      private

        def should_ignore_resource? resource
          return true if Middleman::Util.path_match("#{app.config.images_dir}*", resource.path)
          return true if Middleman::Util.path_match("#{app.config.js_dir}*", resource.path)
          return true if Middleman::Util.path_match("#{app.config.css_dir}*", resource.path)
          return true if Middleman::Util.path_match("#{app.config.fonts_dir}*", resource.path)
          return true unless resource.template?
          false
        end

        def matches_include_paths? resource
          options.paths.each do |path|
            next unless resource.path =~ %r{^#{path}} || resource.destination_path =~ %r{^#{path}}
            return true
          end
          false
        end

        def add_proxy_for_format resource, format
          path_base = if resource.url == '/' || !(resource.path =~ /index\.html$/)
            resource.destination_path.split('.').first.to_s
          else
            resource.destination_path.split('/')[0..-2].join('/').to_s
          end

          path_base.gsub!('/index', '') if app.extensions[:directory_indexes]

          path = "#{path_base}.#{format}"

          proxy = ::Middleman::Sitemap::ProxyResource.new(
            app.sitemap, path, "__api/proxy.#{format}")

          proxy.add_metadata locals: template_data(resource, format)
          proxy.add_metadata options: { layout: false }

          proxy
        end

        # Resource data hash
        # @return [Hash] resource data to be parsed into json
        def template_data resource, format
          metadata = resource.data.select { |k, _v| !options.ignore_metadata_keys.include?(k) }

          {
            format: format,
            resource_data: {
              metadata: Middleman::Util.recursively_enhance(metadata),
              path:     resource.url,
              content:  -> { resource.render }
            }
          }
        end

        def fetch_template
          if options.template
            File.join(app.source_dir, options.template)
          else
            File.expand_path('../template.erb', __FILE__)
          end
        end
    end
  end
end
