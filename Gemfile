source 'https://rubygems.org'

gemspec

gem "rake",     "~> 0.9.2"
gem "rdoc",     "~> 3.9"
gem "yard",     "~> 0.8.0"

if RUBY_VERSION <= "1.9.3"
  gem "pry-debugger"
else
  gem "pry-byebug"
end

group :test do
  gem "middleman", github: "middleman/middleman", branch: "v3-stable" do
    gem "middleman"
    gem "middleman-core"
    gem "middleman-more"
  end

  gem "cucumber", "~> 1.3.0"
  gem "fivemat"
  gem "aruba",    "~> 0.4.11"
  gem "rspec",    "~> 2.7"

  # Template Engines
  gem "redcarpet"
  gem "slim"
  gem "RedCloth"
  gem "liquid"
  gem "haml"
end
