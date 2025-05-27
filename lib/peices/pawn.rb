# # Contains all the methods for the pawn peice
# class Pawn
#   attr_accessor :peice, :color

#   def initialize(piece, color)
#     @peice = piece
#     @color = color
#   end

#   def legal_move?(board, peice, peice_cords, move_cords)
#     legal_moves = possible_positions(board, peice, peice_cords)

#     return true if legal_moves.include?(move_cords)

#     false
#   end

#   # def unocupided_square?(board, piece, move_cords)
#   #   return true unless board[move_cords[0]][move_cords[1]]&.color == piece.color

#   #   false
#   # end

#   # Returns all possible positions for pawn to go to
#   def possible_positions(board, peice, peice_cords) # rubocop:disable Metrics/AbcSize
#     possible_moves = []

#     if peice.color == "white"
#       white_forward(peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
#       white_take(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
#     elsif peice.color == "black"
#       black_forward(peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
#       black_take(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
#     end

#     possible_moves
#   end

#   # Forward moves method for white
#   def white_forward(x, y) # rubocop:disable Naming/MethodParameterName
#     possible_moves = []
#     possible_moves << [x + 1, y] if (x + 1).between?(0, 7)
#     possible_moves << [x + 2, y] if (x + 2).between?(0, 7) && x == 1 # Handles double jump at start
#     possible_moves
#   end

#   # Taking method for white peices
#   def white_take(board, x, y) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Naming/MethodParameterName
#     possible_moves = []

#     if (x + 1).between?(0, 7) && (y - 1).between?(0, 7) && board[x + 1][y - 1]&.color == "black"
#       possible_moves << [x + 1, y - 1]
#     end

#     if (x + 1).between?(0, 7) && (y + 1).between?(0, 7) && board[x + 1][y + 1]&.color == "black"
#       possible_moves << [x + 1, y + 1]
#     end

#     possible_moves
#   end

#   # Forward moves method for black
#   def black_forward(x, y) # rubocop:disable Naming/MethodParameterName
#     possible_moves = []
#     possible_moves << [x - 1, y] if (x - 1).between?(0, 7)
#     possible_moves << [x - 2, y] if (x - 2).between?(0, 7) && x == 6 # Handles double jump at start
#     possible_moves
#   end

#   # Taking method for black peices
#   def black_take(board, x, y) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Naming/MethodParameterName
#     possible_moves = []

#     if (x - 1).between?(0, 7) && (y - 1).between?(0, 7) && board[x - 1][y - 1]&.color == "white"
#       possible_moves << [x - 1, y - 1]
#     end

#     if (x - 1).between?(0, 7) && (y + 1).between?(0, 7) && board[x - 1][y + 1]&.color == " white"
#       possible_moves << [x - 1, y + 1]
#     end

#     possible_moves
#   end
# end
