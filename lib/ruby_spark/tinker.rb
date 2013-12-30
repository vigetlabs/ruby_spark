module RubySpark

  class Tinker < Core
    def digital_write(pin, message)
      response = post('digitalwrite', :params => "D#{pin},#{message}")
      handle(response) do
        response["return_value"] == 1
      end
    end

    def digital_read(pin)
      response = post('digitalread', :params => "D#{pin}")
      handle(response) do
        response["return_value"] == 1 ? "HIGH" : "LOW"
      end
    end

    def analog_write(pin, value)
      response = post('analogwrite', :params => "A#{pin},#{value}")
      handle(response) do
        response["return_value"] == 1
      end
    end

    def analog_read(pin)
      response = post('analogread', :params => "A#{pin}")
      handle(response) do
        response["return_value"]
      end
    end
  end

end
