module RubySpark
  class Core

    def initialize(core_id)
      raise RubySpark::ApiKeyNotDefinedError if RubySpark.auth_token.nil?

      @core_id = core_id
    end

    def digital_write(pin, message)
      client.post('digitalwrite', "D#{pin},#{message}")
    end

    private

    def client
      @client ||= Client.new
    end

  end
end
