# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_multi_vendor/version"

Gem::Specification.new do |s|
  s.name        = 'spree_multi_vendor'
  s.version     = Spree::MultiVendor::VERSION
  s.authors     = ["Chamnap Chhorn"]
  s.email       = ["chamnapchhorn@gmail.com"]
  s.homepage    = "https://github.com/chamnap/spree-multi-vendor"
  s.summary     = %q{Multi Spree stores and Multi vendors}
  s.description = %q{This extension allows a single Spree instance to run multi stores for different vendors (i.e. multi-store, mulit-vendor).}
  s.required_ruby_version = '>= 1.9.2'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('spree_core', '>= 0.60.1')
end
