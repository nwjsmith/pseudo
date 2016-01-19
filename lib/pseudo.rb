# frozen_string_literal: true

# Pseudo a very simple test double that supports stubbing and spies
class Pseudo
  overridden_methods = %i(
    object_id
    respond_to_missing?
    ===
    inspect
    to_s
    public_send
    send
    to_s
  )

  UNSTUBBED_ERROR_MESSAGE = 'unstubbed method %p, expected one of %p'.freeze
  VERY_PRIVATE_METHOD_PREFIX = '__'.freeze

  overridden_methods.each do |overridden_method|
    define_method overridden_method do |*arguments, &block|
      if @stubs.key? overridden_method
        method_missing(overridden_method, *arguments, &block)
      else
        super(*arguments, &block)
      end
    end
  end

  instance_methods.each do |instance_method|
    unless overridden_methods.include?(instance_method) ||
           instance_method.to_s.start_with?(VERY_PRIVATE_METHOD_PREFIX)
      undef_method instance_method
    end
  end

  def initialize
    @stubs = {}
    @received = {}
  end

  def stub(name)
    @stubs[name] = Stub.new
  end

  def method_missing(symbol, *arguments, &block)
    if @stubs.key?(symbol)
      @received[symbol] = arguments
      @stubs[symbol].act(&block)
    else
      fail NoMethodError, Kernel.format(
        UNSTUBBED_ERROR_MESSAGE, symbol, @stubs.keys)
    end
  end

  def received?(message)
    @received.include?(message)
  end

  def received_with?(message, *arguments)
    @received.fetch(message) { return false } == arguments
  end

  def respond_to?(symbol, include_private = false)
    return true if @stubs.key?(symbol)
    super
  end

  # A method stub
  class Stub
    def return(value)
      @returns = value
    end

    def raise(*arguments)
      @raises = arguments
    end

    def yield(value)
      @yields = value
    end

    def act
      return @returns if defined? @returns
      Kernel.fail(*@raises) if defined? @raises
      yield(@yields) if defined?(@yields) && block_given?
      nil
    end
  end
end
