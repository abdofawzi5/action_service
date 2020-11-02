$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'action_service/version'

# Gem description:
Gem::Specification.new do |spec|
  spec.name        = 'action_service'
  spec.version     = ActionService::VERSION
  spec.authors     = ['Abdo Fawzi']
  spec.email       = ['abdofawzi5@gmail.com']
  spec.homepage    = 'https://github.com/abdofawzi5/action_service'
  spec.summary     = 'Is a ruby gem to create and interact easily with services.'
  spec.description = 'Is where you can add your code to do simple functionality instead of make complex controller or models.'
  spec.license     = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
end
