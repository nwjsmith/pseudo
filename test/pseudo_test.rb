require 'test_helper'

class PseudoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Pseudo::VERSION
  end

  def test_stubs_respond_to_stubbed_methods
    double = Pseudo.new
    double.stub(:stubbed_method)

    assert_respond_to double, :stubbed_method
  end

  def test_stubs_return_nil_by_default
    double = Pseudo.new
    double.stub(:default_stub)

    assert_nil double.default_stub
  end

  def test_stubs_are_local_to_double
    double = Pseudo.new
    double.stub(:old_stub)
    new_double = Pseudo.new

    refute_respond_to new_double, :old_stub
  end

  def test_stubs_return_values
    double = Pseudo.new
    double.stub(:stub_with_return).return(123)

    assert_equal 123, double.stub_with_return
  end

  def test_stubs_raise_exceptions
    double = Pseudo.new
    double.stub(:stub_with_raise).raise(ArgumentError, 'bad argument')

    exception = assert_raises(ArgumentError) do
      double.stub_with_raise
    end

    assert_equal 'bad argument', exception.message
  end

  def test_stubs_yield
    double = Pseudo.new
    double.stub(:stub_with_yield).yield(456)

    yielded = nil
    double.stub_with_yield { |value| yielded = value }

    assert_equal 456, yielded
  end

  def test_mocks_record_received
    double = Pseudo.new
    double.stub(:record_it)

    double.record_it

    assert_equal true, double.has_received?(:record_it)
  end
end
