class CommentSerializer < ApplicationSerializer
  attributes :id, :body

  belongs_to :earthquake, serializer: EarthquakeSerializer
end
