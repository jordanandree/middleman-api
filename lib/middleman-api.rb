require "middleman-core"
require "middleman-more"

Middleman::Extensions.register(:api) do
  require "middleman-api/extension"
  Middleman::Api
end
