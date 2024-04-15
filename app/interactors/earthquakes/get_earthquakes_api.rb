class Earthquakes::GetEarthquakesApi < ApplicationInteractor
  def call
    data = Processors::Earthquake.new.get_records!

    ActiveRecord::Base.transaction do
      if earthquakes_atrributes(data['features']).present?
        earthquakes_atrributes(data['features']).each do |record|
          Processors::Earthquake.new.save_record!(record)
        end
      end
    end
    if context.mag_types.present?
      context.earthquakes = Earthquake.where(mag_type: context.mag_types)
    else
      context.earthquakes = Earthquake.all
    end

  rescue ::Errors::Base => e
    handle_error(e)
  end

  def earthquakes_atrributes(data)
    earthquakes_atrributes = []

    data.each do |record|
      return unless record['properties']['title'].present? || record['properties']['url'].present? || record['properties']['place'].present? ||
                record['properties']['magType'].present? || record['geometry']['coordinates'].present?
      return if record['geometry']['coordinates'][0] > 180.0 || record['geometry']['coordinates'][0] < -180.0
      return if record['geometry']['coordinates'][1] > 90.0 || record['geometry']['coordinates'][1] < -90.0
      return if record['properties']['mag'] > 10.0 || record['properties']['mag'] < -10.0
      return if ::Earthquake.find_by(external_id: record['id']).present?

      earthquakes_atrributes << {
        type: record['type'],
        mag_type: record['properties']['magType'],
        external_id: record['id'],
        magnitude: record['properties']['mag'],
        place: record['properties']['place'],
        time: record['properties']['time'],
        tsunami: record['properties']['tsunami'],
        title: record['properties']['title'],
        url: record['properties']['url'],
        longitude: record['geometry']['coordinates'][0],
        latitude: record['geometry']['coordinates'][1]
      }
    end

    earthquakes_atrributes
  end
end
