class ApplicationController < ActionController::API
  SERIALIZER_CLASS = nil
  def paginate_collection(collection, size = nil, number = nil)
    ::Paginators::Pages::ByPagy.new(
      collection,
      size: size || params.dig(:page, :size),
      number: number || params.dig(:page, :number)
    )
  end

  def serialize_collection(collection, page_size: nil, page_number: nil, links: {}, meta: {}, **options)
    collection = collection.reorder(order_definition) if params[:sort]
    page = paginate_collection(collection, page_size, page_number)
    json_pagination = JsonApi::Pagination.new(page.paginator, request)
    serialize_data(
      page.items,
      links: links.merge(json_pagination.links),
      meta: meta.merge(json_pagination.meta),
      **options
    )
  end

  def serialize_data(query, **opts)

    opts[:fields] ||= params[:fields]
    opts[:include] ||= params[:include]
    opts[:root] ||= controller_name.classify.underscore
    self.class::SERIALIZER_CLASS.new(
      query,
      fields: JsonApi::Fields.deep_symbolize(root: opts[:root], criteria: opts[:fields].as_json),
      include: JsonApi::Array.symbolize(opts[:include]),
      links: opts[:links],
      meta: opts[:meta]
    ).serializable_hash
  end

  def error_response(context)
    render json: context[:response], status: context[:status]
  end

end
