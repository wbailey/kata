$: << '.' << File.join(File.dirname(__FILE__), '..', 'lib')

require 'rspec'
require 'kata/base'
require 'simplecov'
require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each {|f| require f}

RSpec.configure do |config|
  config.before(:each) do
    allow(Kata::Base).to receive(:system)
  end
end

SimpleCov.start
