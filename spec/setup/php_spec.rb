require "spec_helper"
require "kata/setup/php"
require "fakefs/spec_helpers"

module Kata
  module Setup
    describe Php do
      describe "#build_tree" do
        include FakeFS::SpecHelpers

        before :each do
          subject.build_tree
          @use_dir = File.join("/", subject.repo_name)

        end

        let(:class_name) {
          subject.kata_name.split(/ |-|_/).map(&:capitalize).join
        }

        it "creates src dir" do
          expect(File.directory?(File.join(@use_dir, "src"))).to be true
        end

        it "creates test dir" do
          expect(File.directory?(File.join(@use_dir, "test"))).to be true
        end

        it "creates README file" do
          expect(File.exists?(File.join(@use_dir, "README"))).to be true
        end

        it "create base class file" do
          expect(File.exists?(File.join(@use_dir, "src", "#{class_name}.php"))).to be true
        end

        it "creates base test file" do
          expect(File.exists?(File.join(@use_dir, "test", "#{class_name}Test.php"))).to be true
        end
      end
    end
  end
end
