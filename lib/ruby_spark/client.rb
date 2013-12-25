module RubySpark
  class Client
    class ApiKeyNotDefinedError < StandardError; end

    def initialize(core_id)
      raise ApiKeyNotDefinedError if ::RubySpark.api_key.nil?

      @core_id = core_id
    end

    def digital_write(pin, message)
      url    = base_url + "/digitalwrite"
      params = access_params.merge(:params => "D#{pin},#{message}")

      HTTParty.post(url, :body => params)
    end

    private

    def base_url
      "https://api.spark.io/v1/devices/#{@core_id}"
    end

    def access_params
      {:access_token => ::RubySpark.api_key}
    end

  end
end
