PROJECT_ROOT_PATH = File.dirname(File.dirname(File.dirname(__FILE__)))
require "middleman-core"
require "middleman-core/step_definitions"

# Don't encode html entities for tests
require 'active_support/json'
ActiveSupport.escape_html_entities_in_json = false

require File.join(PROJECT_ROOT_PATH, 'lib', 'middleman-api')
