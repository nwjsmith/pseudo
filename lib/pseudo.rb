require 'pseudo/version'

class Pseudo
  def initialize
    @stubs = {}
    @received = []
  end

  def stub(name)
    @stubs[name] = Stub.new
  end

  def method_missing(symbol, *arguments, &block)
    if matching_stub = @stubs[symbol]
      @received << symbol
      matching_stub.act(&block)
    else
      super
    end
  end

  def has_received?(message)
    @received.include? message
  end

  def respond_to?(symbol, include_private = false)
    return true if @stubs.has_key?(symbol)
    super
  end

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
      Kernel.raise(*@raises) if defined? @raises
      yield(@yields) if defined?(@yields) && block_given?
      nil
    end
  end
end
