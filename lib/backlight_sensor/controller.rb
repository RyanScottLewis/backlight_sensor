module BacklightSensor
  class Controller
    # Open the USB device
    #
    # @param [String] path The path to the USB device
    def self.open(path, &block)
      new.open(path, &block)
    end

    # Open the USB device
    #
    # @param [String] path The path to the USB device
    def open(path, &block)
      @io = File.open(path, 'r+') # TODO: r+ will create the file if it doesn't exist =( Do a exists? check before this and simply return nil? Or raise error? I hate errorrrs
      sleep(0.1) until !@io.eof?

      @io.readbyte # Sync

      if block_given?
        yield(self)

        close
      end

      self
    end

    # Close the device
    def close
      return if @io.nil?

      @io.close
    end

    # Get the light level from the sensor
    #
    # @return [Integer]
    def read
      @io.write(?r) # Read command
      sleep(0.1) until !@io.eof?

      @io.readbyte
    end

    # Get the light level from the sensor as a percentage
    #
    # @param [Float] max (default: 255) The value representing 100%
    # @return [Float]
    def read_percentage(max=255)
      max    = max.to_f
      value  = read.to_f
      result = (value / max) * 100
      result = 0.0 if result < 0
      result = 100.0 if result > 100

      result
    end
  end
end

