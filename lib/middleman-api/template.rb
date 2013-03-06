module Middleman::Api
  class Template
    def initialize(app)
      @app = app
    end

    # Update the main sitemap resource list
    # @return [void]
    def manipulate_resource_list(resources)
      resources + resources.map do |resource|
        ::Middleman::Sitemap::Resource.new(@app.sitemap, "api.json", template)
      end
    end

    private
      def template
        File.expand_path "../template.json.erb", __FILE__
      end
  end
end
