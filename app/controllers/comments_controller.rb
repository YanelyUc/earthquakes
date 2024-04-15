class CommentsController < ApplicationController

  def create
    context = Comments::Create.call(id: params[:id], body: params[:body])
    return error_response(context) if context.failure?

    render json: context.response
  end

  def destroy
    context = Comments::Destroy.call(id: params[:id])
    error_response(context) if context.failure?
  end
end