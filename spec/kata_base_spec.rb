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

      describe "#questions" do
        it "individually displays question" do
          expect(subject).to receive(:puts).with("\nQuestions:")
          expect(subject).to receive(:puts).with("   - test question 1")
          expect(subject).to receive(:puts).with("   - test question 2")

          subject.questions do
            subject.question "test question 1"
            subject.question "test question 2"
          end
        end

        it "ignores questions when none provided" do
          expect(subject).to_not receive(:puts)

          subject.questions
        end
      end

      describe "#kata" do
        it 'displays summary' do
          expect(subject).to receive(:puts).with('test Kata')

          subject.kata 'test'
        end
      end

      describe '#context' do
        it 'displays' do
          expect(subject).to receive(:puts).with('test Kata')
          expect(subject).to receive(:puts).with('   test context')

          subject.kata 'test' do
            subject.context 'test context'
          end
        end

        it 'accepts requirement' do
          expect(subject).to receive(:puts).with('   test context')
          expect(subject).to receive(:puts).with('      test req')
          expect(subject).to receive(:print)
          expect($stdin).to receive(:gets).and_return('y')
          expect(subject).to receive(:puts).exactly(2).times
          expect(subject).to receive(:system).with(system_call).and_return(0)
          expect(subject).to receive(:puts)

          subject.kata 'test' do
            subject.context 'test context' do
              subject.requirement 'test req'
            end
          end
        end
      end

      describe '#requirement' do
        it 'displays' do
          expect(subject).to receive(:puts).with('   test req')
          expect(subject).to receive(:print)
          expect($stdin).to receive(:gets).and_return('y')
          expect(subject).to receive(:puts).exactly(2).times
          expect(subject).to receive(:system).with(system_call).and_return(0)
          expect(subject).to receive(:puts)

          subject.kata 'test' do
            subject.requirement 'test req'
          end
        end

        it 'accepts example' do
          expect(subject).to receive(:puts).with('   test req')
          expect(subject).to receive(:print)
          expect($stdin).to receive(:gets).and_return('y')
          expect(subject).to receive(:puts).exactly(2).times
          expect(subject).to receive(:system).with(system_call).and_return(0)
          expect(subject).to receive(:puts).exactly(3).times
          expect(subject).to receive(:puts)

          subject.kata 'test' do
            subject.requirement 'test req' do
              subject.example 'test example 1'
              subject.example 'test example 2'
              subject.example 'test example 3'
            end
          end
        end

        it 'accepts detail' do
          expect(subject).to receive(:puts).with('   test req')
          expect(subject).to receive(:print)
          expect($stdin).to receive(:gets).and_return('y')
          expect(subject).to receive(:puts).exactly(2).times
          expect(subject).to receive(:system).with(system_call).and_return(0)
          expect(subject).to receive(:puts).exactly(3).times
          expect(subject).to receive(:puts)

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
