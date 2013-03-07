module Middleman::Api
  class Template
    def initialize(app)
      @app = app
      @app.after_configuration do
        api_formats.each {|f| ignore "api.#{f}"} 
      end
    end

    # Update the main sitemap resource list
    # @return [void]
    def manipulate_resource_list(resources)
      templates = []
      @app.api_formats.each do |f|
        templates << ::Middleman::Sitemap::Resource.new(@app.sitemap, "api.#{f}", template(f))
      end
      resources + templates
    end

    private
      def template(format)
        File.expand_path "../template.#{format}.erb", __FILE__
      end
  end
end