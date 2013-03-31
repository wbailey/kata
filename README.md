## Kata

A kata is defined as an exercise in programming which helps hone your skills through practice and
repetition. Authoring katas is done in blogs but you can't really test yourself. This gem provides a
DSL to author the kata and administer it as a test providing feedback for evaluation.  It also
provides basic github repo setup so that you can chart solution progress over time.

The inspiration for this gem came from my friend [Nick Hengeveld](https://github.com/nickh)

### Installation

It is up on rubygems.org so add it to your project bundle:

    gem kata

or do it the old fashioned way and install the gem manually:

    gem install kata

### Usage

    NAME
        kata - Ruby kata management

    SYNOPSIS
        kata [COMMAND] [ARGS]

    DESCRIPTION
        The kata gem allows one to manage their personal development in the
        practice of writing code through repetition.

    PRIMARY COMMANDS
        kata setup [--no-repo] [--language=option] file
            Setup a github repo for the kata development session.

            --no-repo         - Add the directory tree and files to the current repo if possible
            --language=option - Define the programming language for the directory tree that is built
            file              - Path to the code kata source file for the practice session

        kata take file
            Start a kata development session

        kata version
            Current installed version number

        kata help
            This usage message

### [Wiki](https://github.com/wbailey/kata/wiki)

The [Wiki](https://github.com/wbailey/kata/wiki) has all of the documentation necessary for getting you started.

### DSL Reference

* kata(string, &block)
* context(string, &block)
* requirement(string, &block)
* detail(string)
* example(string)

### Contributors

[Richard Millan](https://github.com/richardiux) updated the tests and forced me to bring more of this up to date

### License

Copyright (c) 2011-2013 Wes Bailey

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

