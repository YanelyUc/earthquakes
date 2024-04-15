class EarthquakesController < ApplicationController
  SERIALIZER_CLASS = ::EarthquakeSerializer
  def get_earthquakes
    context = Earthquakes::GetEarthquakes.call
    return error_response(context) if context.failure?

    render json: serialize_collection(context.earthquakes)
  end

  def get_earthquakes_api
    mag_types = params['filters'] ? params['filters']['mag_type'].split(',') : nil
    context = Earthquakes::GetEarthquakesApi.call(mag_types: mag_types)
    return error_response(context) if context.failure?

    render json: serialize_collection(context.earthquakes)
  end

end