require 'kata/setup/base'

module Kata
  module Setup
    class Ruby < Kata::Setup::Base
      def build_tree
        %w{lib spec helpers matchers}.each { |path| tree(path) }
        readme
        base_class
        dot_rspec
        spec_helper
        kata_spec
        spec_matcher
      end

      private

      def use_kata_name
        kata_name.gsub(/( |-)\1?/, '_').downcase
      end

      def class_name
        kata_name.split(/ |-|_/).map(&:capitalize).join
      end

      def tree(path)
        full_path = case path
          when "lib"
            File.join(repo_name, 'lib')
          when "spec"
            File.join(repo_name, "spec")
          when "matchers"
            File.join(repo_name, "spec", "support", "matchers")
          when "helpers"
            File.join(repo_name, "spec", "support", "helpers")
          end

        FileUtils.mkdir_p(full_path)
      end

      # Using here docs for a cheap templating system
      def readme
        File.open(File.join(repo_name, 'README'), 'w') { |f| f.write(<<EOF) }
Leveling up my ruby awesomeness!
EOF
      end

      def base_class
        # create the base class file
        File.open(File.join(repo_name, 'lib', "#{use_kata_name}.rb"), 'w') {|f| f.write <<EOF}
class #{class_name}
end
EOF
      end

      def dot_rspec
        File.open(File.join(repo_name, '.rspec'), 'w') {|f| f.write <<EOF}
--color --format d
EOF
      end

      def spec_helper
        File.open(File.join(repo_name, 'spec', 'spec_helper.rb'), 'w') {|f| f.write <<EOF}
$: << '.' << File.join(File.dirname(__FILE__), '..', 'lib')

require 'rspec'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}
EOF
      end

      def kata_spec
        File.open(File.join(repo_name, 'spec', "#{use_kata_name}_spec.rb"), 'w') {|f| f.write <<EOF}
require 'spec_helper'
require '#{use_kata_name}'

describe #{class_name} do
  describe "#initialize" do
    it "instantiates" do
      expect {
        #{class_name}.new
      }.to_not raise_error
    end
  end
end
EOF
      end

      def spec_matcher
        File.open(File.join(repo_name, 'spec', 'support', 'matchers', "#{use_kata_name}.rb"), 'w') {|f| f.write <<EOF}
RSpec::Matchers.define :your_method do |expected|
  match do |your_match|
    #expect(your_match.method_on_object_to_execute).to eq(expected)
  end
end
EOF
      end
    end
  end
end
