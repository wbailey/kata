$: << File.join(__FILE__, '..', 'lib')

require 'date'
require 'kata/version'

Gem::Specification.new do |gem|
  gem.name    = 'kata'
  gem.version = Kata::VERSION
  gem.date    = Date.today.to_s
  
  gem.summary = 'A code kata DSL'
  gem.description = "This DSL provides an easy way for you to write a code kata for pairing exercises or individual testing"
  
  gem.authors  = %w/Wes Bailey/
  gem.email    = 'baywes@gmail.com'
  gem.homepage = 'http://github.com/wbailey/kata'
  
  gem.files = Dir['lib/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
  gem.test_files = Dir['spec/**/*'] & `git ls-files -z`.split("\0")
  gem.executables = ['kata']

  gem.add_development_dependency "bundler", ">= 1.0.0"
  gem.add_dependency 'command_line_reporter', '>=3.2.1'
  gem.add_dependency 'octokit'
end
