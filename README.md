## Kata ##

A kata is defined as an exercise in programming which helps hone your skills
through practice and repetition.  Authoring katas has typically been done in 
web pages that do not help administer the test.  This gem provides a DSL to 
author the kata such that when it is run it will also administer a test and 
provide a final report on how much time it took to implement each requirement
that makes up the kata.

### Writing a Kata ###

It is as simple as installing this gem and creating a ruby file much like
an RSpec test as illustrated below:

    require 'kata'

    kata "My First Kata" do
      requirement "Create an add method that will accept two digits as arguments" do
        example "invoking with 1 and 2 returns 3"
        example "invoking with 1 returns 1"
        example "invoking with no arguments returns 0"
      end
    end

Running the kata from the command line yields:

    wesbailey@feynman:~/kata> ruby sample.rb 
    My First Kata
       Create an add method that will accept two digits as arguments
          - invoking with 1 and 2 returns 3
          - invoking with 1 returns 1
          - invoking with no arguments returns 0

    continue (Y|n): 

upon completing the requirements of the kata continue and the report is
displayed:

    Congratulations!
    - Create an add method that will accept two digits as arguments            00:01:07

