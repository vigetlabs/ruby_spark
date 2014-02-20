module RubySpark

  class Core
    class ApiError < StandardError; end

    def initialize(core_id, access_token = RubySpark.access_token)
      raise RubySpark::ConfigurationError.new("Access Token not defined") if access_token.nil?

      @access_token = access_token
      @core_id    = core_id
    end

    def info
      response = get("")
      handle(response) do
        response
      end
    end

    def variable(variable_name)
      response = get(variable_name)
      handle(response) do
        response["result"]
      end
    end

    def function(function_name, arguments)
      response = post(function_name, :params => arguments)
      handle(response) do
        response["return_value"]
      end
    end

    private

    def post(action, params = {})
      url  = base_url + action
      body = access_params.merge(params)

      HTTParty.post(url, :body => body).parsed_response
    end

    def get(action, params = {})
      url  = base_url + action
      query = access_params.merge(params)

      HTTParty.get(url, :query => query).parsed_response
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
      {:access_token => @access_token}
    end
  end

end
