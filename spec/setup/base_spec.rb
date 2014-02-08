require 'spec_helper'
require 'kata/setup/base'
require 'kata/setup/ruby'
require 'fileutils'

module Kata
  module Setup
    describe Base do
      describe "new" do
        it "define a repo name" do
          subject.repo_name.should match /kata-#{Time.now.strftime('%Y-%m-%d')}-\d{6}/
        end

        it "defines the kata name" do
          s = Kata::Setup::Base.new 'my-kata'
          s.kata_name.should == 'my-kata'
        end
      end

      describe "build_tree" do
        it "creates files" do
          expect {
            subject.build_tree
          }.to_not raise_exception

          Dir[File.join(subject.repo_name, '**', '*.rb')].size.should == 4
          Dir[File.join(subject.repo_name, 'README')].size.should == 1
          Dir[File.join(subject.repo_name, '.rspec')].size.should == 1

          FileUtils.remove_entry_secure subject.repo_name
        end
      end
    end
  end
end
