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
        write_repo_file('bootstrap.h',<<EOF)
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
  curl -O https://phar.phpunit.de/phpunit.phar
  mv phpunit.phar phpunit
  chmod 755 phpunit
fi
EOF
      end

      def composer_json
        write_repo_file('composer.json',<<EOF)
{
    "require-dev": {
        "phpunit/phpunit": "4.1.*"
    }
}
EOF
      end

      def base_class
        write_repo_file(File.join('src', "#{class_name}.php"),<<EOF)
<?php

class #{class_name} {

  public function __construct() { }

}

?>
EOF
      end

      def php_test
        write_repo_file(File.join('test', "#{class_name}Test.php"),<<EOF)
<?php

require 'src/#{class_name}.php';

class #{class_name}Test extends PHPUnit_Framework_TestCase {

  public function testInstatiate#{class_name}() {
    try {
      $calc = new #{class_name}();
    } catch (Exception $e) {
      $this->fail();
    }
  }

}

?>
EOF
      end
    end
  end
end

