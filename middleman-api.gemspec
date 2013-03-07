# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-api"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["jordanandree"]
  s.email       = ["jordanandree@gmail.com"]
  # s.homepage    = "http://example.com"
  s.summary     = %q{Middleman API Extension}
  s.description = %q{A Middleman Extension that generates JSON and XML endpoints for template frontmatter}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 3.0.12"])
  s.add_runtime_dependency("middleman-more", [">= 3.0.12"])
  s.add_runtime_dependency("activesupport", ["~> 3.2.12"])
end
