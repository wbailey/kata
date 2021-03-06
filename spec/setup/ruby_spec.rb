require "spec_helper"
require "kata/setup/ruby"
require "fakefs/spec_helpers"

module Kata
  module Setup
    describe Ruby do
      describe "#build_tree" do
        include FakeFS::SpecHelpers

        before :each do
          subject.build_tree
          @use_dir = File.join("/", subject.repo_name)
        end

        it "creates lib dir" do
          expect(File.directory?(File.join(@use_dir, "lib"))).to be true
        end

        it "creates spec dir" do
          expect(File.directory?(File.join(@use_dir, "spec"))).to be true
        end

        it "creates README file" do
          expect(File.exists?(File.join(@use_dir, "README"))).to be true
        end

        it "creates bootstrap file" do
          expect(File.exists?(File.join(@use_dir, "bootstrap.sh"))).to be true
        end

        it "creates Gemfile file" do
          expect(File.exists?(File.join(@use_dir, "Gemfile"))).to be true
        end

        it "create base class file" do
          expect(File.exists?(File.join(@use_dir, "lib", "#{subject.kata_name}.rb"))).to be true
        end

        it "creates dot rspec file" do
          expect(File.exists?(File.join(@use_dir, ".rspec"))).to be true
        end

        it "creates base spec file" do
          expect(File.exists?(File.join(@use_dir, "spec", "#{subject.kata_name}_spec.rb"))).to be true
        end
      end
    end
  end
end
