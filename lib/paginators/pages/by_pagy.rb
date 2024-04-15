module Paginators
  module Pages
    class ByPagy < Base

      def paginator
        @paginate ||= to_dto(Pagy.new(count: collection_size, page: @page_number, items: @page_size))
      end

      def items
        @items ||= begin
                     return @collection[paginator.offset, paginator.size_page] if @collection.is_a?(Array)

                     @collection.offset(paginator.offset).limit(paginator.size_page)
                   end
      end

      private

      def collection_size
        @collection_size ||= @collection.is_a?(Array) ? @collection.size : @collection.count(:all)
      end

      def to_dto(pagy)
        Dto.new(
          offset: pagy.offset,
          limit: pagy.items,
          previous_page: pagy.prev,
          next_page: pagy.next,
          current_page: pagy.page,
          total_pages: pagy.pages,
          total_items: pagy.vars[:count],
          size_page: pagy.items
        )
      end
    end
  end
end