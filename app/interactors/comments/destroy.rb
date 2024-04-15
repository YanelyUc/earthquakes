class Comments::Destroy < ApplicationInteractor
  def call
    comment = Comment.find_by(id: context.id)
    comment.destroy!
  rescue ::ActiveRecord::RecordNotFound => e
    handle_error(e, :not_found) 
  end
end