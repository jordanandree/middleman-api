require "active_support/core_ext"

module Middleman::Api
  class Sitemap
    def initialize(app)
      @app = app
    end

    # Update the main sitemap resource list
    # @return [void]
    def manipulate_resource_list(resources)
      proxies = []
      resources.each do |resource|
        ext = resource.ext.gsub('.','').to_sym
        if resource.template? && !resource.ignored? && !(@app.api_formats.include?(ext))
          @app.api_formats.each do |format|
            path = "#{resource.destination_path.split('.').first}.#{format}"
            proxy = ::Middleman::Sitemap::Resource.new(@app.sitemap, path)
            proxy.proxy_to "api.#{format}"
            proxy.add_metadata locals: template_data(resource, format)
            proxy.add_metadata options: { layout: false }
            proxies << proxy
          end
        end
      end
      proxies + resources
    end

    # Resource data hash
    # @return [Hash] resource data to be parsed into json
    def template_data(resource, format)
      data = {}
      data[:meta] = resource.data
      data[:path] = resource.url
      data[:content] = resource.render
      { data: data.send("to_#{format}") }
    end
  end
end