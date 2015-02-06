# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-api"
  s.version     = "0.1.2"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["jordanandree"]
  s.email       = ["jordanandree@gmail.com"]
  s.homepage    = "http://github.com/jordanandree/middleman-api"
  s.summary     = %q{Middleman Extension that generates JSON and XML endpoints}
  s.description = %q{Middleman Extension that generates JSON and XML endpoints}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency("middleman-core", ["~> 3.0"])
  s.add_runtime_dependency("middleman-more", ["~> 3.0"])
  s.add_runtime_dependency("builder", ["~> 3.2.0"])
end
