module Paginators
  module Pages
    class Base
      def initialize(collection, size: nil, number: nil)
        @collection = collection
        @page_size = size || Paginators::Constants::PAGE_SIZE
        @page_number = number || Paginators::Constants::FIRST_PAGE
      end

      # @return [Paginators::DTO]
      def paginator
        raise NotImplementedError
      end

      # @return [Enumerable]
      def items
        raise NotImplementedError
      end
    end
  end
end
