# Contains all the peices for the rook peice
class King
  attr_accessor :symbol, :peice

  def initialize(symbol, color, peice)
    @symbol = symbol
    @color = color
    @peice = peice
  end
end
