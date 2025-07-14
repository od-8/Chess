# Has the methods which check if there isnt enought pieces left on the board.
# 1 king 1 bishop, 1 king 1 knight, 1 king 2 knights.
module InsufficientMaterial
  def return_all_pieces(color)
    pieces = []
    board.each do |row|
      row.each do |piece|
        pieces << piece if piece&.color == color
      end
    end
    pieces
  end

  # Sorts pieces to an array depending on what piece they are
  # Bishop is added to the bishops array, knight is added to the knights array
  def insufficient_color_material?(color)
    pieces = return_all_pieces(color)

    bishops = []
    knights = []
    other = []

    pieces.each do |piece|
      knights << piece if piece.name == "knight"
      bishops << piece if piece.name == "bishop"
      other << piece unless %w[knight bishop].include?(piece.name)
    end

    not_enough_material?(bishops, knights, other)
  end

  # This checks if there is only a king left and 1 bishop or 1 or 2 knights
  def not_enough_material?(bishops, knights, other)
    return true if (other.length == 1 && bishops.length == 1) ||
                   (other.length == 1 && knights.length < 3) ||
                   (other.length == 1)

    false
  end

  # Checks if both colors dont have enought pieces
  def insufficient_material?
    return true if insufficient_color_material?("white") && insufficient_color_material?("black")

    false
  end
end
