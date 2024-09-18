# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  def setup
    @stack = Stack.new
  end  
  
  def test_add_element
    @stack.push! 'ruby'
    assert_equal @stack.to_a, ['ruby']
  end

  def test_delete_element
    @stack.push! 'ruby'
    @stack.push! 'php'

    @stack.pop!
    assert_equal @stack.to_a, ['ruby']
  end

  def test_clear_element
    @stack.push! 'ruby'
    @stack.clear! 

    assert_empty @stack
  end

  def test_empty_element
    assert_empty @stack
  end
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
