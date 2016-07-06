require 'spec_helper'
require 'kata/setup/base'
require 'kata/setup/ruby'
require 'kata/setup/node'
require 'kata/setup/php'
require 'kata/setup/java'

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

      describe '#create_repo' do
        #subject {Kata::Setup::Base.new}

        let(:no_repo) {OpenStruct.new(:repo => false)}
        let(:with_repo) {OpenStruct.new(:repo => true)}

        it 'only creates if specified' do
          expect(subject).to_not receive(:create_remote_repo)
          expect(subject).to receive(:push_local_repo)

          subject.create_repo(no_repo)
        end

        it 'creates when specified' do
          expect(subject).to receive(:create_remote_repo)
          expect(subject).to receive(:push_local_repo)

          subject.create_repo(with_repo)
        end
      end

      describe "#build_tree" do
        subject {Kata::Setup::Base.new}

        let(:ruby_setup) {Kata::Setup::Ruby.new('kata')}
        let(:node_setup) {Kata::Setup::Node.new('kata')}
        let(:php_setup) {Kata::Setup::Php.new('kata')}
        let(:java_setup) {Kata::Setup::Java.new('kata')}

        it 'invokes the ruby setup' do
          expect(Kata::Setup::Ruby).to receive(:new).and_return(ruby_setup)
          expect(ruby_setup).to receive(:build_tree)

          subject.build_tree 'ruby'
        end

        it 'invokes the node setup' do
          expect(Kata::Setup::Node).to receive(:new).and_return(node_setup)
          expect(node_setup).to receive(:build_tree)

          subject.build_tree 'node'
        end

        it 'invokes the php setup' do
          expect(Kata::Setup::Php).to receive(:new).and_return(php_setup)
          expect(php_setup).to receive(:build_tree)

          subject.build_tree 'php'
        end

        it 'invokes the java setup' do
          expect(Kata::Setup::Java).to receive(:new).and_return(java_setup)
          expect(java_setup).to receive(:build_tree)

          subject.build_tree 'java'
        end

        it 'rejects invalid language types' do
          expect {
            subject.build_tree 'asdf'
          }.to raise_error
        end
      end
    end
  end
end
