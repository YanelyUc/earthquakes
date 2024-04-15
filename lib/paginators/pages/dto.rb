module Paginators
  module Pages
    class Dto
      attr_reader :offset, :limit, :previous, :next, :current, :total_pages, :total_items, :size_page
      alias :last :total_pages

      def initialize(offset:, limit:, previous_page:, next_page:, current_page:, total_pages:, total_items:, size_page:)
        @offset = offset
        @limit = limit
        @previous = previous_page
        @next = next_page
        @current = current_page
        @total_pages = total_pages
        @total_items = total_items
        @size_page = size_page
      end
    end
  end
end