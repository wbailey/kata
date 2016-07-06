require 'spec_helper'
require 'kata/setup/java'
require 'fakefs/spec_helpers'

module Kata
  module Setup
    describe Java do
      describe '#build_tree' do
        include FakeFS::SpecHelpers

        before :each do
          subject.build_tree
          @use_dir = File.join('/', subject.repo_name)
        end

        it 'creates src dirs' do
          expect(File.directory?(File.join(@use_dir, 'src', 'main', 'java'))).to be true
          expect(File.directory?(File.join(@use_dir, 'src', 'main', 'resources'))).to be true
          expect(File.directory?(File.join(@use_dir, 'src', 'test', 'resources'))).to be true
          expect(File.directory?(File.join(@use_dir, 'src', 'test', 'resources'))).to be true
        end

        it 'creates README file' do
          expect(File.exist?(File.join(@use_dir, 'README'))).to be true
        end

        it 'creates build.gradle file' do
          expect(File.exist?(File.join(@use_dir, 'build.gradle'))).to be true
        end

        it 'creates settings.gradle file' do
          expect(File.exist?(File.join(@use_dir, 'settings.gradle'))).to be true
        end

        it 'create kata main file' do
          check_src_file 'main', 'Kata.java'
        end

        it 'creates kata test file' do
          check_src_file 'test', 'KataTest.java'
        end

        def check_src_file(folder, name)
          expect(File.exist?(File.join(@use_dir, 'src', folder, 'java', 'kata',
                                       name))).to be true
        end
      end
    end
  end
end
