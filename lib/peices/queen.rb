# Contains all the methods for the queen peice
class Queen
  attr_accessor :symbol, :peice

  def initialize(symbol, color, peice)
    @symbol = symbol
    @color = color
    @peice = peice
  end
end
