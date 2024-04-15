class EarthquakeSerializer < ApplicationSerializer
  attributes :id, :mag_type, :external_id, :magnitude, :place, :time, :tsunami, 
              :title, :url

  has_many :coordinates, serializer: CoordinateSerializer
end