require 'test_helper'

class PseudoTest < Minitest::Test
  parallelize_me!

  def setup
    @double = Pseudo.new
  end

  def test_that_it_has_a_version_number
    refute_nil Pseudo::VERSION
  end

  def test_stubs_respond_to_stubbed_methods
    @double.stub(:stubbed_method)

    assert_respond_to @double, :stubbed_method
  end

  def test_stubs_return_nil_by_default
    @double.stub(:default_stub)

    assert_nil @double.default_stub
  end

  def test_stubs_are_local_to_double
    @double.stub(:old_stub)
    new_double = Pseudo.new

    refute_respond_to new_double, :old_stub
  end

  def test_stubs_return_values
    @double.stub(:stub_with_return).return(123)

    assert_equal 123, @double.stub_with_return
  end

  def test_stubs_raise_exceptions
    @double.stub(:stub_with_raise).raise(ArgumentError, 'bad argument')

    exception = assert_raises(ArgumentError) { @double.stub_with_raise }
    assert_equal 'bad argument', exception.message
  end

  def test_stubs_yield
    @double.stub(:stub_with_yield).yield(456)

    yielded = nil
    @double.stub_with_yield { |value| yielded = value }

    assert_equal 456, yielded
  end

  def test_mocks_record_received
    @double.stub(:record_it)
    @double.stub(:never_called)

    @double.record_it

    assert_equal true, @double.received?(:record_it)
    assert_equal false, @double.received?(:never_called)
  end

  def test_doubles_record_received_with_arguments
    @double.stub(:record_it)

    @double.record_it(:argument)

    assert_equal true, @double.received_with?(:record_it, :argument)
    assert_equal false, @double.received_with?(:record_it, :joke)
  end

  def test_keeps_double_underscored_method_definitions
    assert_respond_to @double, :__send__
  end

  def test_stubbing_object_id
    @double.stub(:object_id).return('received object_id')

    assert_equal 'received object_id', @double.object_id
  end

  def test_stubbing_respond_to_missing
    @double.stub(:respond_to_missing?).return('received respond_to_missing?')

    assert_equal 'received respond_to_missing?', @double.respond_to_missing?
  end

  def test_stubbing_case_equality
    @double.stub(:===).return('received ===')

    assert_equal 'received ===', @double.===
  end

  def test_stubbing_inspect
    @double.stub(:inspect).return('received inspect')

    assert_equal 'received inspect', @double.inspect
  end

  def test_stubbing_to_s
    @double.stub(:to_s).return('received to_s')

    assert_equal 'received to_s', @double.to_s
  end

  def test_stubbing_public_send
    @double.stub(:public_send).return('received public_send')

    assert_equal 'received public_send', @double.public_send
  end

  def test_stubbing_send
    @double.stub(:send).return('received send')

    assert_equal 'received send', @double.send
  end

  def test_send_returns_stubbed_return_value
    @double.stub(:sendable).return(123)

    assert_equal 123, @double.send(:sendable)
  end

  def test_public_send_returns_stubbed_return_value
    @double.stub(:sendable).return(123)

    assert_equal 123, @double.send(:sendable)
  end

  def test_raises_no_method_error_on_unstubbed_methods
    @double.stub(:stubbed)

    exception = assert_raises(NoMethodError) { @double.unstubbed }
    assert_equal 'unstubbed method :unstubbed, expected one of [:stubbed]',
                 exception.message
  end
end
