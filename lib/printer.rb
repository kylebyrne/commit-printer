require "serialport"

class Printer
  def initialize(port, baud_rate)
    @port = port
    @baud_rate = baud_rate
  end

  def print(text)
    SerialPort.open(@port, @baud_rate) do |sp|
      sp.write(text)
    end
  end
end
