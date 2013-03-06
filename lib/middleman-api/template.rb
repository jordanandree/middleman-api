module Middleman::Api
  class Template
    def initialize(app)
      @app = app
      @proxy_name = "api.json"
      @app.ignore @proxy_name
    end

    # Update the main sitemap resource list
    # @return [void]
    def manipulate_resource_list(resources)
      resources + resources.map do |resource|
        ::Middleman::Sitemap::Resource.new(@app.sitemap, @proxy_name, template)
      end
    end

    private
      def template
        File.expand_path "../template.json.erb", __FILE__
      end
  end
end