require 'date'

Gem::Specification.new do |gem|
  gem.name    = 'kata'
  gem.version = '0.1.0'
  gem.date    = Date.today.to_s
  
  gem.summary = 'A code kata DSL'
  gem.description = "extended description"
  
  gem.authors  = %w/Wes Bailey/
  gem.email    = 'wes.bailey@insiderpages.com'
  gem.homepage = 'http://github.com/wbailey/kata'
  
  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*',
                  'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
end
