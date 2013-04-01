require 'fileutils'
require 'ostruct'

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
        # Setup from github configuration
        raise Exception, 'Git not installed' unless system 'which git > /dev/null'

        github = OpenStruct.new :url => 'https://api.github.com/'

        github_user, shell_user = %x{git config --get github.user}.chomp, ENV['USER']

        github.user = github_user.empty? ? shell_user : github_user

        raise Exception, 'Unable to determine github user' if github.user.empty?

        github.token = %x{git config --get github.token}.chomp

        if github.token.empty?
          # Create new token per instructions at
          # https://help.github.com/articles/creating-an-oauth-token-for-command-line-use
          print 'GitHub: ' 
          github.token = `curl -s -u #{github.user} \
            -d '{"scopes":["repo"],"note":"Ruby kata"}' \
            #{github.url}authorizations | grep token \
            | cut -f4 -d'"'`.chomp
          # Cache it for reuse
          cmd = "git config --add github.token #{github.token}"
          system(cmd)
        end
        raise Exception, 'Unable to determine github api token' if github.token.empty?

        # Create the repo on github
        if options.repo
          print 'Creating github repo...'
          repo_json = `curl -s -H 'Authorization: token #{github.token}' \
            -d '{"name": "#{repo_name}", "description": "code+kata+repo"}' \
            #{github.url}user/repos`
          raise Exception, 'unable to use curl to create repo on github' \
            if !repo_json.include? \
            "\"url\": \"#{github.url}repos/#{github.user}/#{repo_name}\","
          puts 'complete'
        end

        # publish to github

        print 'creating files for repo and initializing...'

        cmd = "cd #{repo_name} &&"
        if options.repo
          cmd << "git init >/dev/null 2>&1 &&"
          cmd << "git add README .rspec lib/ spec/ >/dev/null 2>&1 &&"
        else
          cmd << "git add #{ENV['PWD']}/#{repo_name} >/dev/null 2>&1;"
        end
        cmd << "git commit -m 'starting kata' > /dev/null 2>&1;"
        cmd << "git remote add origin \
          git@github.com:#{github.user}/#{repo_name}.git \
          >/dev/null 2>&1 &&" if options.repo
        cmd << 'git push origin master'

        raise SystemCallError, 'unable to add files to github repo' unless system(cmd)

        puts 'done'
        puts "You can now change directories to #{repo_name} and take your kata"
      end

      def repo_name=(kata_name)
        @repo_name = "#{kata_name.gsub(/( |-)\1?/, '_')}-#{Time.now.strftime('%Y-%m-%d-%H%M%S')}".downcase
      end

      def build_tree(type = 'ruby')
        case type
        when 'ruby'
          Kata::Setup::Ruby.new(kata_name).build_tree
        end
      end
    end
  end
end
