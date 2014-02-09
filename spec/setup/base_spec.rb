require 'spec_helper'
require 'kata/setup/base'
require 'kata/setup/ruby'
require 'fileutils'
require 'fakefs'

module Kata
  module Setup
    describe Base do
      describe "#new" do
        it "defines a repo name" do
          expect(subject.repo_name).to match(/kata-#{Time.now.strftime('%Y-%m-%d')}-\d{6}/)
        end

        it "defines the kata name" do
          s = Kata::Setup::Base.new 'my-kata'
          expect(s.kata_name).to eq('my-kata')
        end
      end
    end
  end
end
