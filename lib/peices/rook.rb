# Contains all the methods for the rook peices
class Rook
  attr_accessor :symbol, :peice

  def initialize(symbol, color, peice)
    @symbol = symbol
    @color = color
    @peice = peice
  end
end
