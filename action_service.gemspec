$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "action_service/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "action_service"
  s.version     = ActionService::VERSION
  s.authors     = ["abdofawzi"]
  s.email       = ["abdofawzi5@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ActionService."
  s.description = "TODO: Description of ActionService."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.6"

  s.add_development_dependency "sqlite3"
end
