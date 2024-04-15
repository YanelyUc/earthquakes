
module Providers
  module Usgs
    module Endpoints
      class Earthquakes
        def self.method
          :GET
        end

        def self.url
          ENV['URL_API']
        end
      end
    end
  end
end
