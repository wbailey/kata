## Kata ##

A kata is defined as an exercise in programming which helps you hone your skills
through practice and repetition.  Finding katas to work on is a challenge and
to this point the only location was through mail archives and random blog posts.
The purpose of this gem is to provide a series of tools that make it easy to
author, setup and administer a kata.

### Authoring a Kata ###

Authoring a kata is as simple as installing this gem and creating a ruby file
much like an RSpec test as illustrated below:

    kata "My First" do
      requirement "Create an add method that will accept two digits as arguments" do
        example "invoking with 1 and 2 returns 3"
        example "invoking with 5 only returns 5"
        example "invoking with no arguments returns 0"
      end
      requirement "Modify the add method to access multple digits as arguments" do
        example "invoking with 1 and 2 and 3 returns 6"
        example "invoking with 1 and 2 and 3 and 4 and 5 returns 15"
      end
      context "outside" do
        requirement "first requirment" do
          detail "has detail"
          example "1+1  = 2"
        end
        requirement "second requirment" do
          detail "has detail"
          example "1+1  = 2"
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

2. The **context()** method allows for grouping of requirements with 2 arguments:

    * *string* - A description of the provided context
    * *&block* - A ruby block consisting of a call to *requirement()*

this method call is optional and not required to define a kata.

3. The **requirement()** method is the heart of a kata as it is used to provide the
business rules that the code should provide solutions to.  It follows the same
pattern of the other methods with 2 arguments:

    * *string* - A description of the requirement that the code implementing the
      kata should meet
    * *&block* - A ruby block consisting of calls to *detail()* or *example()*

4. The **detail()** method takes a single argument allowing for further defintion
of a requirement.  This method can be called repeatedly in a block.

    * *string* - A description of the detail of requirement

5. The **example()** method takes a single argument allowing for illustration of
examples of the requirement in practice

    * *string* - An example that will help illustrate the requirement in practice

### Setting up a Kata ###

To setup a minimal github repo you must first already have a github account and
git installed on your machine.  To build a kata repo simply use the setup
command:

    wesbailey@feynman:~/my-katas> kata setup sample.rb
    {"repository":{"has_downloads":true,"url":". ... 011-03-11-165513/.git/
    [master (root-commit) 804036f] starting kata
     5 files changed, 25 insertions(+), 0 deletions(-)
     create mode 100644 README
     create mode 100644 lib/my_first.rb
     create mode 100644 spec/my_first_spec.rb
     create mode 100644 spec/spec_helper.rb
     create mode 100644 spec/support/matchers/my_first.rb
    Counting objects: 11, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (6/6), done.
    Writing objects: 100% (11/11), 973 bytes, done.
    Total 11 (delta 0), reused 0 (delta 0)
    To git@github.com:wbailey/my_first-2011-03-11-165513.git
     * [new branch]      master -> master

### Administering a Kata ###

Running the kata from the command line yields:

    wesbailey@feynman:~/my-katas> kata stringcalculator.rb
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
