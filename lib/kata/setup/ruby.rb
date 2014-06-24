require 'kata/setup/base'

module Kata
  module Setup
    class Ruby < Kata::Setup::Base
      def build_tree
        %w{lib spec}.each { |path| tree(path) }
        readme
        bootstrap
        base_class
        dot_rspec
        kata_spec
      end

      private

      def tree(path)
        full_path = case path
          when "lib"
            File.join(repo_name, 'lib')
          when "spec"
            File.join(repo_name, "spec")
          end

        FileUtils.mkdir_p(full_path)
      end

      def bootstrap
        write_repo_file('bootstrap.sh',<<EOF)
#!/bin/bash
gem install bundler
bundle install
EOF
      end

      def gemfile
        write_repo_file('Gemfile',<<EOF)
source 'http://rubygems.org'

group :test do
  gem 'rspec'
  gem 'autotest'
end

group :development do
  gem 'debugger'
  gem 'pry'
end
EOF
      end

      # Using here docs for a cheap templating system
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
    end
  end
end
