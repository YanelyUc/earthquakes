class Comments::Create < ApplicationInteractor
  def call
    earthquake = Earthquake.find_by(id: context.id)

    ActiveRecord::Base.transaction do
      context.response = Comment.create!(
        body: context.body,
        earthquake_id: earthquake.id
      )
    end
  end
end
