# Pseudo

Pseudo is very simple test double library that supports only the features which support good mocking practices:

* Stubbing
* Spy-style mocking

## WARNING: Pseudo probably isn't ready for prime time just yet

## Stubs

Stub a method.

``` ruby
double = Pseudo.new
double.stub(:stubbed_method)
double.stubbed_method # => nil
```

Stub a method with a return value.

``` ruby
double = Pseudo.new
double.stub(:stub_with_return).return(123)
double.stub_with_return # => 123
```

Stub a method to yield a value.

``` ruby
double = Pseudo.new
double.stub(:stub_with_yield).yield(456)
double.stub_with_yield do |value|
  value # => 456
end
```

Stub a method to raise an exception.

``` ruby
double = Pseudo.new
double.stub(:stub_with_raise).raise(ArgumentError, 'bad argument')
double.stub_with_raise
# ArgumentError: bad argument
#         from ...
```

## Spies

Spies are a form of mock that doesn't break up the [four-phase test structure](http://xunitpatterns.com/Four%20Phase%20Test.html).

``` ruby
def test_setup_exercise_verify_teardown
  double = Pseudo.new
  double.stub(:record_it)
  double.stub(:never_called)

  double.record_it

  assert_equal true, double.has_received?(:record_it)
  assert_equal false, double.has_received?(:never_called)
end
```