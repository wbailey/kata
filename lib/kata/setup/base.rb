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
        else
          raise(ArgumentError, "Invalid language type #{type}")
        end
      end

      private

      def use_kata_name
        kata_name.gsub(/( |-)\1?/, '_').downcase
      end

      def class_name
        kata_name.split(/ |-|_/).map(&:capitalize).join
      end

      def write_repo_file(use_file, use_contents)
        File.open(File.join(repo_name, use_file), 'w') {|f| f.write(use_contents)}
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
            tmp = OpenStruct.new

            github_user = %x{git config --get github.user}.chomp
            shell_user = ENV['USER']

            tmp.user = github_user.empty? ? shell_user : github_user

            raise Exception, 'Unable to determine github user' if tmp.user.empty?

            print 'Github account password: '
            tmp.password = STDIN.noecho(&:gets).chomp

            tmp
          end
      end

      def client
        @client ||= Octokit::Client.new(:login => github.user, :password => github.password)
      end

      def create_session_token
        authorization = client.create_authorization({:scopes => ['public_repo'], :note => 'Code Kata'})

        github.token = authorization.token

        cmd = "git config --add github.token #{github.token}"
        raise SystemCallError, 'Unable to cache github api token' unless system(cmd)
      end

      def create_remote_repo
        create_session_token

        puts "Creating remote repo..."
        client.create_repo "#{repo_name}"
        puts "end"
      end

      def push_local_repo(new_repo)
        print "creating files for repo and initializing..."

        cmd = "cd #{repo_name} &&"

        if new_repo
          cmd << "git init >/dev/null 2>&1 &&"
          cmd << "git add README .rspec lib/ spec/ >/dev/null 2>&1 &&"
        else
          cmd << "git add #{ENV['PWD']}/#{repo_name} >/dev/null 2>&1;"
        end

        cmd << "git commit -m 'starting kata' > /dev/null 2>&1;"

        if new_repo
          cmd << "git remote add origin git@github.com:#{github.user}/#{repo_name}.git >/dev/null 2>&1 &&"
        end

        cmd << 'git push origin master'

        raise SystemCallError, 'unable to add files to github repo' unless system(cmd)

        puts 'done'
        puts "You can now change directories to #{repo_name} and take your kata"
      end
    end
  end
end
