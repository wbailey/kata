require 'fileutils'
require 'ostruct'
require 'octokit'
require 'io/console'

module Kata
  module Setup
    class Base
      attr_accessor :kata_name
      attr_reader :repo_name

      def initialize(kata_name = 'kata')
        self.kata_name = kata_name
        self.repo_name = kata_name
      end

      def create_repo options
        create_remote_repo if options.repo

        push_local_repo(options.repo)
      end

      def repo_name=(kata_name)
        @repo_name = "#{kata_name.gsub(/( |-)\1?/, '_')}-#{Time.now.strftime('%Y-%m-%d-%H%M%S')}".downcase
      end

      def build_tree(type = 'ruby')
        case type
        when 'ruby'
          Kata::Setup::Ruby.new(kata_name).build_tree
        when 'node'
          Kata::Setup::Node.new(kata_name).build_tree
        when 'php'
          Kata::Setup::Php.new(kata_name).build_tree
        when 'java'
          Kata::Setup::Java.new(kata_name).build_tree
        else
          raise(ArgumentError, "Invalid language type #{type}")
        end
      end

      private

      def tree(*path)
        FileUtils.mkdir_p(File.join(repo_name, path))
      end

      def use_kata_name
        kata_name.gsub(/( |-)\1?/, '_').downcase
      end

      def class_name
        kata_name.split(/ |-|_/).map(&:capitalize).join
      end

      def write_repo_file(use_file, use_contents, permissions = 0644)
        File.open(File.join(repo_name, use_file), 'w') do |f|
          f.write(use_contents)
          f.chmod(permissions) rescue Exception
        end
      end

      def readme
        write_repo_file('README',<<EOF)
Leveling up my coding awesomeness!
EOF
      end

      def github
        # Setup from github configuration
        raise Exception, 'Git not installed?  Could not find git using which' unless system('which git > /dev/null')

        @github ||=
          begin
            struct = OpenStruct.new

            struct.token = %x{git config --get github.token}.chomp

            github_user = %x{git config --get github.user}.chomp
            shell_user = ENV['USER']

            struct.user = github_user.empty? ? shell_user : github_user

            struct
          end
      end

      def client_factory
        if github.token
          # nothing to do
        elsif github.user
          get_password
          get_token
        else
          raise Exception, 'Unable to determine github.token or github.user' if github.user.empty?
        end

        client.access_token = github.token
      end

      def client
        @client ||= Octokit::Client.new
      end

      def get_password
        print 'Github account password: '
        github.password = STDIN.noecho(&:gets).chomp
      end

      def get_token
        client.login = github.user
        client.password = github.password

        authorization = client.create_authorization({:scopes => ['public_repo'], :note => 'Code Kata'})

        github.token = authorization.token

        cmd = "git config --add github.token #{github.token}"
        raise SystemCallError, 'Unable to cache github api token' unless system(cmd)
      end

      def create_remote_repo
        client_factory

        begin
          print "Creating remote repo..."
          client.create_repo "#{repo_name}"
        rescue Exception
          puts "\nError: unable to create the git repo."
          print 'Proceeding...'
        ensure
          puts "done"
        end
      end

      def push_local_repo(new_repo)
        cmd = "cd #{repo_name} &&"

        if new_repo
          cmd << "git init &&"
          #cmd << "git add README .rspec lib/ spec/ &&"
          cmd << "git add . &&"
        else
          cmd << "git add #{ENV['PWD']}/#{repo_name};"
        end

        cmd << "git commit -m 'starting kata';"

        if new_repo
          cmd << "git remote add origin git@github.com:#{github.user}/#{repo_name}.git &&"
        end

        cmd << 'git push origin master'

        raise SystemCallError, 'unable to add files to github repo' unless system(cmd)

        puts 'done'
        puts "You can now change directories to #{repo_name} and take your kata"
      end
    end
  end
end
