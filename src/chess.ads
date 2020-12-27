package Chess is
   size : constant := 8;
   type letter is (a, b, c, d, e, f, g, h);
   subtype X is integer range 1 .. size;
   subtype Y is integer range 1 .. size;

   type Piece is (pawn, rook, knight, bishop, queen, king);
   subtype Player_Piece is
   type Cell is (empty);
   type Board is array (size,size) of Cell;

   game_board : Board;

   function is_valid_move() return Boolean with Ghost;
   procedure move_piece(x_start : in X; y_start : in Y; x_end : in X; y_end : in Y) with Pre => is_valid_move;

private

end Chess;
