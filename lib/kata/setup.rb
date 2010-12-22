module Kata
  module Setup
    def build_repo(kata_name)
      build_tree(kata_name)
    end
    
    def build_tree(kata_name)
      repo = 'kata-' + Time.now.strftime('%Y-%m-%d-%H:%M')
      %W{#{repo}/lib #{repo}/spec/support/helpers #{repo}/spec/support/matchers}.each {|path| mkdir_p path}
    end

    # FileUtils really depends on rmagick? grrr
    def mkdir_p(path)
      %x{mkdir -p #{path}}
    end
  end
end
