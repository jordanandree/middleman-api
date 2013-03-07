require "middleman-api/template"
require "middleman-api/sitemap"

# Extension namespace
module Middleman::Api
  class << self

    # Called when extension is activated
    def registered(app, options={})
      # Add class methods to context
      app.send :include, ClassMethods

      app.after_configuration do
        # Register json.erb template
        sitemap.register_resource_list_manipulator(:middleman_api_template, Middleman::Api::Template.new(self), false)

        # Register resource manipulator for pages with frontmatter
        sitemap.register_resource_list_manipulator(:middleman_api, Middleman::Api::Sitemap.new(self), false)
      end
    end

    alias :included :registered

    module ClassMethods
      # @return [Hash]
      def api_formats
        [:json, :xml]
      end
    end

  end
end
