module Processors
  class Earthquake
    def initialize
      @client = ::ApiClients::RestClient.new
    end
    
    def get_records!
      response = @client.make(Providers::Usgs::Endpoints::Earthquakes, payload)
    rescue ::RestClient::Exception => e
      raise e.message, e.http_body
    end

    def payload
      @payload ||= {
        format: 'geojson',
        starttime: 1.month.ago.strftime("%Y-%m-%d"),
        endtime: Date.current.strftime("%Y-%m-%d")
      }
    end

    def save_record!(record)
      earthquake = ::Earthquake.create!(
        record.except(:latitude, :longitude)
      )

      ::Coordinate.create!(
        earthquake_id: earthquake.id,
        longitude: record[:longitude],
        latitude: record[:latitude]
      )
    end
  end
end

