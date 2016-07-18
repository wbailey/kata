require 'kata/setup/base'

module Kata
  module Setup
    # Provides support for java language setup
    class Java < Kata::Setup::Base
      def build_tree
        %w(main test).each do |path|
          tree("src", path, 'java', 'kata', use_kata_name)
          tree("src", path, 'resources')
        end
        readme
        bootstrap
        build_gradle
        settings_gradle
        dot_files
        kata_class
        kata_test
      end

      private

      def bootstrap
        write_repo_file('bootstrap.sh', <<EOF)
#!/bin/bash
mv build.gradle build.gradle.tmp
mv settings.gradle settings.gradle.tmp
gradle init
mv build.gradle.tmp build.gradle
mv settings.gradle.tmp settings.gradle
gradle build
EOF
      end

      def settings_gradle
        write_repo_file('settings.gradle', <<EOF)
rootProject.name='#{use_kata_name}'
EOF
      end

      def build_gradle
        write_repo_file('build.gradle', <<EOF)
apply plugin: 'java'

group 'kata'
version '1.0-SNAPSHOT'

repositories {
    mavenCentral()
}

dependencies {
    testCompile group: 'junit', name: 'junit', version: '4.12'
}
EOF
      end

      def dot_files
        write_repo_file('.gitignore', <<EOF)
build
target
out
.gradle

*.iml
.idea
.project
.classpath
.settings

.DS_STORE
EOF
      end

      def kata_class
        write_src_file('main', "#{class_name}.java", <<EOF)
package kata.#{use_kata_name};

public class #{class_name} {
}
EOF
      end

      def kata_test
        write_src_file('test', "#{class_name}Test.java", <<EOF)
package kata.#{use_kata_name};

import org.junit.Assert;
import org.junit.Test;

public class #{class_name}Test {
    @Test
    public void testInitialize() {
        Assert.assertNotNull(new #{class_name}());
    }
}
EOF
      end

      def write_src_file(folder, name, content)
        File.open(File.join(repo_name, 'src', folder, 'java', 'kata',
                            use_kata_name, name), 'w') { |f| f.write content }
      end
    end
  end
end
