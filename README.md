## Kata ##

A kata is defined as an exercise in programming which helps hone your skills
through practice and repetition.  Authoring katas is done in blogs with no
real way of testing yourself for improvement.  This gem provides a DSL to 
author the kata and administer it as a test providing feedback for evaluation.

### Writing a Kata ###

It is as simple as installing this gem and creating a ruby file much like
an RSpec test as illustrated below:

    require 'kata'

    kata "My First Kata" do
      requirement "Create an add method that will accept two digits as arguments" do
        example "invoking with 1 and 2 returns 3"
        example "invoking with 5 only returns 5"
        example "invoking with no arguments returns 0"
      end
      requirement "Modify the add method to access multple digits as arguments" do
        example "invoking with 1 and 2 and 3 returns 6"
        example "invoking with 1 and 2 and 3 and 4 and 5 returns 15"
      end
    end

### Taking a Kata ###

Running the kata from the command line yields:

    wesbailey@feynman:~/kata> ruby sample.rb
    My First Kata
       Create an add method that will accept two digits as arguments
          - invoking with 1 and 2 returns 3
          - invoking with 1 returns 1
          - invoking with no arguments returns 0

    continue (Y|n): 

       Modify the add method to access multple digits as arguments
          - invoking with 1 and 2 and 3 returns 6
          - invoking with 1 and 2 and 3 and 4 and 5 returns 15

    continue (Y|n): 


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
