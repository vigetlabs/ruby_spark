module RubySpark
  class Client

    def initialize(core_id)
      raise RubySpark::AuthTokenNotDefinedError if RubySpark.auth_token.nil?

      @core_id = core_id
    end

    def digital_write(pin, message)
      response = post('digitalwrite', "D#{pin},#{message}")
      response.parsed_response["return_value"] == 1
    end

    def digital_read(pin)
      response = post('digitalread', "D#{pin}")
      response.parsed_response["return_value"] == 1 ? "HIGH" : "LOW"
    end

    private

    def post(action, params)
      url  = base_url + action
      body = access_params.merge(:params => params)

      response = HTTParty.post(url, :body => body)
    end

    def base_url
      "https://api.spark.io/v1/devices/#{@core_id}/"
    end

    def access_params
      {:access_token => RubySpark.auth_token}
    end
  end
end
