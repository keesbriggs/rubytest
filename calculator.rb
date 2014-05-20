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
    # accept ```1\n2,3``` as input, per instructions
    # accept ```//;\n1;2``` as input defining args and delimiter

    delimiter = ','
    negative_args = []

    if args.first.class == String
      very_first_arg = args.first.split(/\\n/).first
      delimiter = very_first_arg if is_not_numeric? very_first_arg
      args = args.first.split(/\\n|#{delimiter}/).map(&:to_i)
    end

    @total = args.inject(0) do |sum, arg|
      if is_negative? arg
        negative_args << arg
        next
      end
      sum + arg
    end
    if negative_args.any?
      raise StandardError, "The following negative numbers are not allowed as input: #{negative_args.inspect}"
    end
    @total
  end

  def is_not_numeric? input
    input !~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
  end

  def is_negative? input
    input.to_s =~ /^-/
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

  def test_add_arguments_delimited_by_newline_or_comma
    calculator = Calculator.new
    calculator.add('''1\n1,1''')
    assert_equal(3, calculator.total)
  end

  def test_add_arguments_delimited_by_newline_or_comma_with_multiple_digits
    calculator = Calculator.new
    calculator.add('''1\n1,11''')
    assert_equal(13, calculator.total)
  end

  def test_add_arguments_with_custom_delimiter_on_preceding_line
    calculator = Calculator.new
    calculator.add(''';\n1;2''')
    assert_equal(3, calculator.total)
  end

  def test_add_arguments_with_negative_number_input_throws_error
    assert_raise(StandardError) do
      calculator = Calculator.new
      calculator.add(-1)
    end
  end
end