require 'spec_helper'
require 'calculator'

describe Calculator do
  describe "#initialize" do
    it "instantiates" do
      expect {
        Calculator.new
      }.to_not raise_exception
    end
  end
end
