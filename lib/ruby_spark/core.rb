module RubySpark
  class Core
    class ApiError < StandardError; end

    def initialize(core_id, auth_token = RubySpark.auth_token)
      raise RubySpark::AuthTokenNotDefinedError if auth_token.nil?

      @auth_token = auth_token
      @core_id    = core_id
    end

    def digital_write(pin, message)
      response = post('digitalwrite', "D#{pin},#{message}")
      handle(response) do
        response["return_value"] == 1
      end
    end

    def digital_read(pin)
      response = post('digitalread', "D#{pin}")
      handle(response) do
        response["return_value"] == 1 ? "HIGH" : "LOW"
      end
    end

    def analog_write(pin, value)
      response = post('analogwrite', "A#{pin},#{value}")
      handle(response) do
        response["return_value"] == 1
      end
    end

    def analog_read(pin)
      response = post('analogread', "A#{pin}")
      handle(response) do
        response["return_value"]
      end
    end

    private

    def post(action, params)
      url  = base_url + action
      body = access_params.merge(:params => params)

      HTTParty.post(url, :body => body).parsed_response
    end

    def handle(response, &block)
      if error = error_from(response)
        raise ApiError.new(error) if error.length > 0
      else
        yield block
      end
    end

    def error_from(response)
      response["error"].tap do |error|
        description = response["error_description"]
        error.concat(": #{description}") if description
        error.concat(": Invalid Core ID") if error == "Permission Denied"
      end
    end

    def base_url
      "https://api.spark.io/v1/devices/#{@core_id}/"
    end

    def access_params
      {:access_token => @auth_token}
    end
  end
end
