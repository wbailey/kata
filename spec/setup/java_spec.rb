require 'spec_helper'
require 'kata/setup/java'
require 'fakefs/spec_helpers'

module Kata
  # Defines tests for the java language setup
  module Setup
    describe Java do
      describe '#build_tree' do
        include FakeFS::SpecHelpers

        before :each do
          subject.build_tree
          @use_dir = File.join('/', subject.repo_name)
        end

        it 'creates src dirs' do
          check_src_dirs 'main'
          check_src_dirs 'test'
        end

        it 'creates README file' do
          check_file 'README'
        end

        it 'creates .gitignore file' do
          check_file '.gitignore'
        end

        it 'creates build.gradle file' do
          check_file 'build.gradle'
        end

        it 'creates settings.gradle file' do
          check_file 'settings.gradle'
        end

        it 'create kata main file' do
          check_src_file 'main', 'Kata.java'
        end

        it 'creates kata test file' do
          check_src_file 'test', 'KataTest.java'
        end

        def check_file(name)
          expect(File.exist?(File.join(@use_dir, name))).to be true
        end

        def check_src_file(folder, name)
          expect(File.exist?(File.join(@use_dir, 'src', folder, 'java', 'kata',
                                       subject.kata_name, name))).to be true
        end

        def check_src_dirs(folder)
          check_src_dir folder, 'java'
          check_src_dir folder, 'resources'
        end

        def check_src_dir(folder, name)
          expect(File.directory?(File.join(@use_dir, 'src', folder, name)))
            .to be true
        end
      end
    end
  end
end
