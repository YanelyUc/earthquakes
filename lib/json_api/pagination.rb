class JsonApi::Pagination

  def initialize(paginator, request)
    @paginator = paginator
    @request = request
  end

  def links
    {
      first: to_url(::Paginators::Constants::FIRST_PAGE),
      prev: to_url(@paginator.previous),
      self: to_url(@paginator.current),
      next: to_url(@paginator.next),
      last: to_url(@paginator.last)
    }
  end

  def meta
    {
      count: @paginator.total_items,
      page: { total: @paginator.total_pages }
    }
  end

  private

  def to_url(page_number)
    params = @request.query_parameters.except(:page).merge(page: { number: page_number, size: @paginator.total_items })
    page_number && "#{@request.base_url}#{@request.path}?#{params.to_query}"
  end
end