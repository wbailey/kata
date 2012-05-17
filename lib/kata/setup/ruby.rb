require 'kata/setup/base'

module Kata
  module Setup
    class Ruby < Kata::Setup::Base
      def build_tree
        %W{#{repo_name}/lib #{repo_name}/spec/support/helpers #{repo_name}/spec/support/matchers}.each {|path| FileUtils.mkdir_p path}

        use_kata_name = kata_name.gsub(/( |-)\1?/, '_').downcase
        class_name = kata_name.split(/ |-|_/).map(&:capitalize).join

        # create the README file so github is happy
        File.open(File.join(repo_name, 'README'), 'w') {|f| f.write <<EOF}
Leveling up my ruby awesomeness!
EOF

        # create the base class file
        File.open(File.join(repo_name, 'lib', "#{use_kata_name}.rb"), 'w') {|f| f.write <<EOF}
class #{class_name}
end
EOF
        # create the .rspec file
        File.open(File.join(repo_name, '.rspec'), 'w') {|f| f.write <<EOF}
--color --format d
EOF

        # create the spec_helper.rb file
        File.open(File.join(repo_name, 'spec', 'spec_helper.rb'), 'w') {|f| f.write <<EOF}
$: << '.' << File.join(File.dirname(__FILE__), '..', 'lib')

require 'rspec'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}
EOF

        # create a working spec file for the kata
        File.open(File.join(repo_name, 'spec', "#{use_kata_name}_spec.rb"), 'w') {|f| f.write <<EOF}
require 'spec_helper'
require '#{use_kata_name}'

describe #{class_name} do
  describe "#initialize" do
    it "instantiates" do
      expect {
        #{class_name}.new
      }.should_not raise_exception
    end
  end
end
EOF
        # stub out a custom matchers file
        File.open(File.join(repo_name, 'spec', 'support', 'matchers', "#{use_kata_name}.rb"), 'w') {|f| f.write <<EOF}
RSpec::Matchers.define :your_method do |expected|
  match do |your_match|
    #your_match.method_on_object_to_execute == expected
  end
end
EOF
      end
    end
  end
end
