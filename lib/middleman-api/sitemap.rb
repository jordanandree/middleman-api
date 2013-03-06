module Middleman::Api
  class Sitemap
    def initialize(app)
      @app = app
      @proxy_to = "api.json"
    end

    # Update the main sitemap resource list
    # @return [void]
    def manipulate_resource_list(resources)
      proxies = []
      resources.each do |resource|
        if resource.path != @proxy_to && resource.template?
          path = "#{resource.path.split('.').first}.json"
          proxy = ::Middleman::Sitemap::Resource.new(@app.sitemap, path)
          proxy.proxy_to @proxy_to
          proxy.add_metadata json_hash(resource)
          proxies << proxy
        end
      end
      proxies + resources
    end

    # Resource data hash
    # @return [Hash] resource data to be parsed into json
    def json_hash(resource)
      json = {}
      json[:meta] = resource.data
      json[:content] = @app.render_individual_file(resource.source_file)
      {locals: { json: json.to_json }}
    end
  end
end