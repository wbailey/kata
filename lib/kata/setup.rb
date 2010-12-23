require 'fileutils'

module Kata
  class Setup
    GITHUB_URL = 'http://github.com/api/v2/json/'

    attr_reader :kata_name

    def create_repo(kata_name = 'kata')
      self.kata_name = kata_name

      raise StandardError unless git_installed?

      user_string = "-u '#{github_user}/token:#{github_token}'"
      repo_params = "-d 'name=#{kata_name}' -d 'description=code+kata+repo'"

      %Q{curl #{user_string} #{repo_params} #{GITHUB_URL}/repos/create}

      #%x{curl -u "wbailey/token:`git config --get github.token`" -d 'name=kata-#{Time.now}' -d 'description=code kata repo' 'http://github.com/api/v2/json/repos/create'}

      #build_tree(kata_name)
      #exec "cd #{repo}; git init; git commit -am 'starting kata'; git push origin master"
    end

    private

    def kata_name= base_name
      @kata_name ||= base_name + '-' + Time.now.strftime('%Y-%m-%d-%H-%M-%S')
    end

    def git_installed?
      system 'which git > /dev/null'
    end

    def github_token
      @github_token ||= begin
        token = %x{git config --get github.user}.chomp
        raise Exception, 'Unable to determine github api token' if token.empty?
      end
    end

    def github_user
      @github_user ||= begin
        github_user = %x{git config --get github.user}.chomp
        shell_user = ENV['USER']

        raise Exception, 'Unable to determine github user' if github_user.empty? && shell_user.empty?

        github_user || shell_user
      end
    end
    
    def build_tree kata_name
      %W{#{repo}/lib #{repo}/spec/support/helpers #{repo}/spec/support/matchers}.each {|path| FileUtils.mkdir_p path}
    end

    def repo
      @repo ||= kata_name + Time.now.strftime('%Y-%m-%d-%H:%M')
    end
  end
end
