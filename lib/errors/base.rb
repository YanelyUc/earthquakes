module Errors
  class Base < StandardError
    attr_reader :source
    attr_accessor :path

    def initialize(message, source = nil, key: nil)
      @source = source || :unknown
      @key = key
      super(message)
    end

    def to_h
      to_error(message, source, key: @key)
    end
  end
end