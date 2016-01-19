# Pseudo

[![Circle CI](https://circleci.com/gh/nwjsmith/pseudo.svg?style=svg)](https://circleci.com/gh/nwjsmith/pseudo)
[![Code Climate](https://codeclimate.com/github/nwjsmith/pseudo/badges/gpa.svg)](https://codeclimate.com/github/nwjsmith/pseudo)
[![Test Coverage](https://codeclimate.com/github/nwjsmith/pseudo/badges/coverage.svg)](https://codeclimate.com/github/nwjsmith/pseudo)

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

## Requirements

* Ruby 2.0.0+
* Nothing else. No gem dependencies, nothing.

## Installation

The best way to install Pseudo is with RubyGems:

```
$ [sudo] gem install pseudo
```

## Contribute

If you'd like to make some changes to Pseudo, start by forking the repo on GitHub:

http://github.com/nwjsmith/pseudo

The best way to get contributions merged into Pseudo:

1. Clone down your fork.
2. Create a well-named topic branch for your change
3. Make your change.
4. Add tests and make sure everything passes (see the section on running the tests below).
5. If you are adding new functionality, document it in the README.
6. Do not change the version number.
7. If necessary, rebase your commits into logical chunks, with no failing commits.
8. Push the branch to GitHub.
9. Send a pull request to the nwjsmith/pseudo project.

## Run the tests

``` bash
$ bundle install
$ bundle exec rake test
```

## License

Pseudo is released under the [MIT License](http://opensource.org/licenses/MIT).
