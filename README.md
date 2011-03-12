## Kata ##

A kata is defined as an exercise in programming which helps hone your skills
through practice and repetition.  Finding katas to work on is a challenge and
to this point the only location is through mail archives and random blog posts.
The purpose of this gem is to provide a series of tools that make it easy to
author, setup and administer a kata.

This gem provides a DSL to 
author the kata and administer it as a test providing feedback for evaluation.


This gem also gives you the ability to setup a minimal github repo specific to
the time you take the kata.  This allows you to review your commit history as
well as record your katas so that you can evaluate improvement over time by
comparing recent solutions to older ones.

### Authoring a Kata ###

It is as simple as installing this gem and creating a ruby file much like
an RSpec test as illustrated below:

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
    end

This is a very simple DSL that consists of 3 methods that really doesn't really
need any more explanation than the above example.

### Setting up a Kata ###

To setup a minimal github repo you must first already have a github account
and git installed on your machine.  If you don't have them you should so go
and do it now and then come back to this point.  To build a kata repo simply
use the setup command:

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

### Taking a Kata ###

Running the kata from the command line yields:

    wesbailey@feynman:~/my-katas> ruby sample.rb
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
