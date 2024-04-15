class Earthquakes::GetEarthquakes < ApplicationInteractor
  def call
    context.earthquakes = Earthquake.all
  end
end
