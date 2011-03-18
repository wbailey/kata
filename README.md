## Kata ##

A kata is defined as an exercise in programming which helps you hone your skills
through practice and repetition.  Finding katas to work on is a challenge and
to this point the only location was through mail archives and random blog posts.
The purpose of this gem is to provide a series of tools that make it easy to
author, setup and administer a kata.

### Authoring a Kata ###

Authoring a kata is as simple as installing this gem and creating a ruby file
much like an RSpec test as illustrated below:

    kata "String Calculator" do
      requirement "Create an add method that will accept two digits as arguments" do
        example "invoking with 1 and 2 returns 3"
        example "invoking with 5 only returns 5"
        example "invoking with no arguments returns 0"
      end
      requirement "Modify the add method to access multple digits as arguments" do
        example "invoking with 1 and 2 and 3 returns 6"
        example "invoking with 1 and 2 and 3 and 4 and 5 returns 15"
      end
      context "sub" do
        requirement "Create a sub method that will accept two digits as arguments" do
          detail "Negative numbers are not allowed"
          detail "Digits must range from 0-9"
          example "9-6 = 3"
        end
        requirement "Modify the sub method to access multple digits as arguments" do
          example "9-6-3 = 0"
        end
      end
     end

There are five methods that can be used to author a kata that have a hierarchy
illustrated below:

    1. kata
      2. context
        3. requirement
          4. detail
          5. example

1. The **kata()** method sets up the test to administer and starts the clock running.
It takes 2 arguments:

    * *string* - The name of the kata that will be displayed when taking it as well as
    being used in creating the parent directory of the github repo during setup.
    * *&block* - A ruby block that includes calls to *context()* or *requirement()*

1. The **context()** method allows for grouping of requirements with 2 arguments:

    * *string* - A description of the provided context
    * *&block* - A ruby block consisting of a call to *requirement()*

    this method call is optional and not required to define a kata.

1. The **requirement()** method is the heart of a kata as it is used to provide the
business rules that the code should provide solutions to.  It follows the same
pattern of the other methods with 2 arguments:

    * *string* - A description of the requirement that the code implementing the
      kata should meet
    * *&block* - A ruby block consisting of calls to *detail()* or *example()*

1. The **detail()** method takes a single argument allowing for further defintion
of a requirement.  This method can be called repeatedly in a block.

    * *string* - A description of the detail of requirement

1. The **example()** method takes a single argument allowing for illustration of
examples of the requirement in practice

    * *string* - An example that will help illustrate the requirement in practice

### Setting up a Kata ###

To setup a minimal github repo you must first already have a github account and
git installed on your machine.  To build a kata repo simply use the setup
command:

    wesbailey@feynman:~/scratch-1.9.0> kata setup sample.rb
    Creating github repo...complete
    creating files for repo and initializing...done
    You can now change directories to my_first-2011-03-17-225948 and take your kata

Looking in that directory you can see what files have been created:

    .rspec
    README
    lib
    lib/my_first.rb
    spec
    spec/my_first_spec.rb
    spec/spec_helper.rb
    spec/support
    spec/support/helpers
    spec/support/matchers
    spec/support/matchers/my_first.rb

For the files that are generated you will see the following default contents:

*.rspec*

    --color --format d

*README*

    Leveling up my ruby awesomeness!

*lib/my_first.rb*

    class MyFirst
    end

*spec/my_first_spec.rb*

    require 'spec_helper'
    require 'my_first'

    describe MyFirst do
      describe "new" do
        it "should instantiate" do
          lambda {
            MyFirst.new
          }.should_not raise_exception
        end
      end
    end

*spec/spec_helper.rb*

    $: << '.' << File.join(File.dirname(__FILE__), '..', 'lib')

    require 'rspec'

    Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

*spec/support/matchers/my_first.rb*

    RSpec::Matchers.define :your_method do |expected|
      match do |your_match|
        #your_match.method_on_object_to_execute == expected
      end
    end

Following TDD the first test has been written and passes:

    wesbailey@feynman:~/katas/my_first-2011-03-17-225948> rspec spec/

    MyFirst
      new
        should instantiate

    Finished in 0.0005 seconds
    1 example, 0 failures

With rspec configured you can also run autotest if you have it installed.
    
### Administering a Kata ###

Running the kata from the command line yields:

    wesbailey@feynman:~/katas> kata stringcalculator.rb
    String Calculator Kata
       Create an add method that will accept two digits as arguments
          - invoking with 1 and 2 returns 3
          - invoking with 1 returns 1
          - invoking with no arguments returns 0

    continue (Y|n): 

At this point you should go into your setup and start coding until this
requirement is completed.  Once it is then enter and the next requirement will
appear as illustrated below:

       Modify the add method to access multple digits as arguments
          - invoking with 1 and 2 and 3 returns 6
          - invoking with 1 and 2 and 3 and 4 and 5 returns 15

    continue (Y|n): 

The process continues until all of the requirements have been coded.  The
kata will keep track of the ammount of time it takes for you to complete coding.

### Completing the Kata ###

After completing the requirements of the kata continue and the report is
displayed:

    Congratulations!
    - Create an add method that will accept two digits as arguments            00:02:02
    - Modify the add method to access multple digits as arguments              00:00:45

### Installing Kata ###

It is up on rubygems.org so add it to your bundle or do it the old fashioned
way with:

    gem install kata
