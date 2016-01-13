$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "attr_object/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "attr_object"
  s.version     = AttrObject::VERSION
  s.authors     = ["dsimard"]
  s.email       = ["dsimard@azanka.ca"]
  s.homepage    = "https://github.com/dsimard/attr_object"
  s.summary     = "Value Objects for Ruby on Rails"
  s.description = "Value Objects should be used to have more capabilities on a model attribute in Rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4"

  s.add_development_dependency "sqlite3"
end
