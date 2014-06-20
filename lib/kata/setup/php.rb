require 'kata/setup/base'

module Kata
  module Setup
    class Php < Kata::Setup::Base
      def build_tree
        %w{src test}.each { |path| tree(path) }
        readme
        bootstrap
        composer_json
        base_class
        php_test
      end

      private

      def tree(path)
        full_path = case path
          when "src"
            File.join(repo_name, 'src')
          when "test"
            File.join(repo_name, "test")
          end

        FileUtils.mkdir_p(full_path)
      end

      # Using here docs for a cheap templating system
      def bootstrap
        File.open(File.join(repo_name, 'bootstrap.sh'), 'w') { |f| f.write(<<EOF) }
#!/bin/sh

php_version=$(php -v | head -1 | awk '{print $2}'  | sed 's/\\.//g')
composer_version=5320

if [[ $php_version -gt $composer_version ]]; then
  curl -sS https://getcomposer.org/installer | php
  mv composer.phar composer
  chmod 755 composer
  ./composer install
  export PATH=vendor/bin:$PATH
else
  if [ -z $(which wget) ]; then
    echo "please install wget to proceed"
    exit 1
  fi

  wget https://phar.phpunit.de/phpunit.phar
  mv phpunit.phar phpunit
  chmod 755 phpunit
fi
EOF
      end

      def composer_json
        File.open(File.join(repo_name, 'composer.json'), 'w') { |f| f.write(<<EOF) }
{
    "require-dev": {
        "phpunit/phpunit": "4.1.*"
    }
}
EOF
      end

      def base_class
        # create the base class file
        File.open(File.join(repo_name, 'src', "#{class_name}.php"), 'w') {|f| f.write <<EOF}
<?php

class #{class_name} {
}

?>
EOF
      end

      def php_test
        File.open(File.join(repo_name, 'test', "#{class_name}Test.php"), 'w') {|f| f.write <<EOF}
<?php

require 'src/#{class_name}.php';

class #{class_name}Test extends PHPUnit_Framework_TestCase {

}
?>
EOF
      end
    end
  end
end

