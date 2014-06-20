require 'kata/setup/base'

module Kata
  module Setup
    class Javascript < Kata::Setup::Base
      def build_tree
        %w{lib spec}.each { |path| tree(path) }
        readme
        base_class
        kata_spec
      end

      private

      def use_kata_name
        kata_name.gsub(/( |-)\1?/, '_').downcase
      end

      def class_name
        kata_name.split(/ |-|_/).map(&:capitalize).join
      end

      def tree(path)
        full_path = case path
          when "lib"
            File.join(repo_name, 'lib')
          when "spec"
            File.join(repo_name, "spec")
          end

        FileUtils.mkdir_p(full_path)
      end

      # Using here docs for a cheap templating system
      def readme
        File.open(File.join(repo_name, 'README'), 'w') { |f| f.write(<<EOF) }
Leveling up my Javascript and Node awesomeness!
EOF
      end

      def base_class
        # create the base class file
        File.open(File.join(repo_name, 'lib', "#{use_kata_name}.js"), 'w') {|f| f.write <<EOF}
var expression = null;

exports.getExpr = function() { 
  return this.expression;
};
EOF
      end

      def kata_spec
        File.open(File.join(repo_name, 'spec', "#{use_kata_name}_spec.rb"), 'w') {|f| f.write <<EOF}
var calculator = require("../lib/calculator");

describe("#{class_name}", function() {
  it("sets the expression", function() {
    var expectation = "1,2";
    calculator.setExpr(expectation);
    var expr = calculator.getExpr();
    expect(expr).toBe(expectation);
  });
});
EOF
      end
    end
  end
end

