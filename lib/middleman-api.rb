require 'middleman-core'

Middleman::Extensions.register(:api) do
  require 'middleman-api/extension'
  Middleman::Api::Extension
end
