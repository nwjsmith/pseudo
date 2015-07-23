require 'pseudo/version'

class Pseudo
  def initialize
    @stubs = []
  end

  def stub(name)
    Stub.new(name).tap { |stub| @stubs << stub }
  end

  def method_missing(symbol, *arguments, &block)
    if matching_stub = @stubs.find { |stub| stub.name == symbol }
      matching_stub.act(&block)
    else
      super
    end
  end

  def respond_to?(symbol, include_private = false)
    return true if @stubs.any? { |stub| stub.name == symbol }
    super
  end

  class Stub
    attr_reader :name

    def initialize(name)
      @name = name
    end

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
