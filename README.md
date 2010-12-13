## Kata ##

    require 'kata'

    kata "String Calculator Kata" do
      requirement "Create a simple string calculator with a method add that takes a string" do
        example %q{The string can contain 0, 1 or 2 numbers for example "", "1", "1,2"}
        example "The method will return the sum of the digits"
        example "Then empty string will return 0"
      end

      requirement "Allow the string to contain an unknown amount of numbers" do
        example %q{"1,2,3" sums to 6}
        example %q{"1,2,5,8" sums to 16}
      end

      requirement "Allow the add method to handle new lines between numbers (instead of commas)" do
        example %q{"1\n2\n3" sums to 6}
        example %q{"2,3\n4" sums to 9}
        example %q{Consecutive use of delimeters ("1,\n2") should raise an exception}
      end

      requirement %q{Calling add with a negative number will throw an exception "negatives not allowed"} do
        example "The exception will list the negative number that was in the string"
        example "The exception should list all negatives if there is more than one"
      end

      requirement "Allow the add method to handle a different delimiter" do
        example %q{To change a delimiter, the beginning of the string will contain a separate line "//[delimeter]\n...}
        example "This line is optional and all previous tests should pass"
        example %q{"//[;]\n1;2" sums to 3}
        example %q{"1;2" should raise an exception}
      end

      requirement "Allow the add method to handle multiple different delimeters" do
        example %q{multiple delimeters can be specified in the separate line "//[delimeter][delimeter]...[delimeter]\n...}
        example %q{"//[*][;]\n1*2;3" sums to 6}
        example %q{"//[*][;][#]\n1*2;3#4" sums to 10}
        example %q{"//[#][;][*]\n1*2#3;4,5\n6" sums to 21}
      end
    end
