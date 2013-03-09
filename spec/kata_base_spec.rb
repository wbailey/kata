require 'spec_helper'
require 'kata/base'

module Kata
  module Base
    describe 'DSL' do
      let :use_class do
        Class.new do
          include Kata::Base
        end
      end

      subject { use_class.new }

      let(:system_call) {"git add . && git commit -m 'test req' > /dev/null"}

      describe "#kata" do
        it 'displays summary' do
          subject.should_receive(:puts).with('test Kata')

          subject.kata 'test'
        end
      end

      describe '#context' do
        it 'displays' do
          subject.should_receive(:puts).with('test Kata')
          subject.should_receive(:puts).with('   test context')

          subject.kata 'test' do
            subject.context 'test context'
          end
        end

        it 'accepts requirement' do
          subject.should_receive(:puts).with('   test context')
          subject.should_receive(:puts).with('      test req')
          subject.should_receive(:print)
          $stdin.should_receive(:gets).and_return('y')
          subject.should_receive(:puts).exactly(2).times
          subject.should_receive(:system).with(system_call).and_return(0)
          subject.should_receive(:puts)

          subject.kata 'test' do
            subject.context 'test context' do
              subject.requirement 'test req'
            end
          end
        end
      end

      describe '#requirement' do
        it 'displays' do
          subject.should_receive(:puts).with('   test req')
          subject.should_receive(:print)
          $stdin.should_receive(:gets).and_return('y')
          subject.should_receive(:puts).exactly(2).times
          subject.should_receive(:system).with(system_call).and_return(0)
          subject.should_receive(:puts)

          subject.kata 'test' do
            subject.requirement 'test req'
          end
        end

        it 'accepts example' do
          subject.should_receive(:puts).with('   test req')
          subject.should_receive(:print)
          $stdin.should_receive(:gets).and_return('y')
          subject.should_receive(:puts).exactly(2).times
          subject.should_receive(:system).with(system_call).and_return(0)
          subject.should_receive(:puts).exactly(3).times
          subject.should_receive(:puts)

          subject.kata 'test' do
            subject.requirement 'test req' do
              subject.example 'test example 1'
              subject.example 'test example 2'
              subject.example 'test example 3'
            end
          end
        end

        it 'accepts detail' do
          subject.should_receive(:puts).with('   test req')
          subject.should_receive(:print)
          $stdin.should_receive(:gets).and_return('y')
          subject.should_receive(:puts).exactly(2).times
          subject.should_receive(:system).with(system_call).and_return(0)
          subject.should_receive(:puts).exactly(3).times
          subject.should_receive(:puts)

          subject.kata 'test' do
            subject.requirement 'test req' do
              subject.detail 'test detail 1'
              subject.detail 'test detail 2'
              subject.detail 'test detail 3'
            end
          end
        end
      end
    end
  end
end
