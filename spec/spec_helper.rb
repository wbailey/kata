$: << '.' << File.join(File.dirname(__FILE__), '..', 'lib')

require 'rspec'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:each) do
    allow(Kata::Base).to receive(:system)
  end
end

