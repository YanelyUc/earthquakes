module ApiClients
  class RestClient    
    def make(endpoint, payload = {})
      response = execute(endpoint.method, endpoint.url, payload)
      JSON.parse(response.body)
    end

    private

    def headers
      {
        content_type: 'application/json',
        accept: :json
      }.with_indifferent_access.freeze
    end

    def execute(method, url, payload)
      puts "url: #{url}"
      puts "payload: #{payload}"
      ::RestClient.get(url, params: payload, headers: headers)
    end
  end
end
