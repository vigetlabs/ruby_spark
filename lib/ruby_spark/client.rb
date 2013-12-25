module RubySpark
  class Client

    def post(action, params)
      url  = base_url + action
      body = access_params.merge(:params => params)

      HTTParty.post(url, :body => body)
    end

    private

    def base_url
      "https://api.spark.io/v1/devices/#{@core_id}/"
    end

    def access_params
      {:access_token => RubySpark.auth_token}
    end

  end
end
