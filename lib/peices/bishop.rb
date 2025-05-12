# Contains all the methods for the bishop peices
class Bishop
  attr_accessor :symbol, :peice

  def initialize(symbol, color, peice)
    @symbol = symbol
    @color = color
    @peice = peice
  end
end
