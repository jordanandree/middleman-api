source 'https://rubygems.org'

gemspec

group :development do
  gem "rake",     "~> 0.9.2"
  gem "rdoc",     "~> 3.9"
  gem "yard",     "~> 0.8.0"
end

group :test do
  gem "middleman", github: "middleman/middleman", branch: "master" do
    gem "middleman"
    gem "middleman-core"
    gem "middleman-more"
  end

  gem "cucumber", "~> 1.2.0"
  gem "fivemat"
  gem "aruba",    "~> 0.4.11"
  gem "rspec",    "~> 2.7"
  gem "pry-debugger"

  # Template Engines
  gem "redcarpet"
  gem "slim"
  gem "RedCloth"
  gem "liquid"
  gem "haml"
end
