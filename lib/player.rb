# Contains all the methods for the player
class Player
  attr_accessor :name, :color

  def initialize(name, color)
    @name = name.capitalize
    @color = color.downcase
  end
end
