## Setup
=begin
1. Create a `public` repository in your github account
2. Follow the test instructions below.

## Instructions

1. Create a simple String calculator with a method Add(numbers) that takes a string
 - The method can take 0, 1 or 2 numbers, and will return their sum (for an empty string it will
  return 0) for example ```""``` or ```"1"``` or ```"1,2"```
 - Start with the simplest test case of an empty string and move to 1 and two numbers
 - Commit with the comment **Step 1** and push.
2. Allow the Add method to handle an unknown amount of numbers. Commit with the comment **Step 2** and push.
3. Allow the Add method to handle new lines between numbers (instead of commas).
 - the following input is ok: ```1\n2,3``` (will equal 6)
 - the following input is NOT ok: ```1,\n```
 - Make sure you only test for correct inputs. there is no need to test for invalid inputs
 - Commit with the comment **Step 3** and push.
4. Allow the Add method to handle a different delimiter:
 - to change a delimiter, the beginning of the string will contain a separate line that looks like
this: ```//[delimiter]\n[numbers…]``` for example ```//;\n1;2``` should return three where the
default delimiter is ```;``` .
 - the first line is optional. all existing scenarios should still be supported
 - Commit with the comment **Step 4** and push.
5. Calling Add with a negative number will throw an exception “negatives not allowed” – and
the negative that was passed.if there are multiple negatives, show all of them in the exception message. Commit with the comment **Step 5** and push.
=end

require 'test/unit'

class Calculator
  attr_reader :total

  def add(*args)
    @total = args.inject(0) { |sum, arg| sum + arg }
  end
end

class CalculatorTest < Test::Unit::TestCase
  def test_add_no_arguments
    calculator = Calculator.new
    calculator.add
    assert_equal(0, calculator.total)
  end

  def test_add_one_argument
    calculator = Calculator.new
    calculator.add(1)
    assert_equal(1, calculator.total)
  end

  def test_add_two_arguments
    calculator = Calculator.new
    calculator.add(1, 999)
    assert_equal(1000, calculator.total)
  end

  def test_add_fourteen_arguments
    calculator = Calculator.new
    calculator.add(1,1,1,1,1,1,1,1,1,1,1,1,1,1)
    assert_equal(14, calculator.total)
  end
end