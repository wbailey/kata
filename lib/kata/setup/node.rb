require 'kata/setup/base'

module Kata
  module Setup
    class Node < Kata::Setup::Base
      def build_tree
        %w{lib spec}.each { |path| tree(path) }
        readme
        package_json
        kata_file
        kata_spec
      end

      private

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
      def package_json
        write_repo_file('package.json',<<EOF)
{
  "name": "#{use_kata_name}",
  "version": "0.0.1",
  "dependencies": {
    "jasmine-node": "latest"
  },
  "private": true
}
EOF
      end

      def kata_file
        # create the base class file
        write_repo_file(File.join('lib', "#{use_kata_name}.js"),<<EOF)
var expression = null;

exports.getExpr = function() { 
  return this.expression;
};
EOF
      end

      def kata_spec
        write_repo_file(File.join('spec', "#{use_kata_name}_spec.js"),<<EOF)
var #{use_kata_name} = require("../lib/#{use_kata_name}");

describe("#{class_name}", function() {
  it("sets the expression", function() {
    var expectation = "1,2";
    #{use_kata_name}.setExpr(expectation);
    var expr = #{use_kata_name}.getExpr();
    expect(expr).toBe(expectation);
  });
});
EOF
      end
    end
  end
end

