require "spec_helper"
require "kata/setup/node"
require "fakefs/spec_helpers"

module Kata
  module Setup
    describe Node do
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

        it "creates package.json file" do
          expect(File.exists?(File.join(@use_dir, "package.json"))).to be true
        end

        it "creates autotest file" do
          expect(File.exists?(File.join(@use_dir, "autotest"))).to be true
        end

        it "create kata main file" do
          expect(File.exists?(File.join(@use_dir, "lib", "#{subject.kata_name}.js"))).to be true
        end

        it "creates kata spec file" do
          expect(File.exists?(File.join(@use_dir, "spec", "#{subject.kata_name}_spec.js"))).to be true
        end
      end
    end
  end
end
