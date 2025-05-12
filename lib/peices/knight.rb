# Contains all the methods for the knight peices
class Knight
  attr_accessor :symbol, :peice

  def initialize(symbol, color, peice)
    @symbol = symbol
    @color = color
    @peice = peice
  end
end
