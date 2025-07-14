# Handles when its is impossible for checkmate
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

  def not_enough_material?(bishops, knights, other)
    return true if (other.length == 1 && bishops.length == 1) ||
                   (other.length == 1 && knights.length < 3) ||
                   (other.length == 1)

    false
  end

  def insufficient_material?
    return true if insufficient_color_material?("white") && insufficient_color_material?("black")

    false
  end
end
