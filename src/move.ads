with Chess; use Chess;

package Move is
    function is_valid_pawn(dx : in Integer; dy : in Integer; Move : in Move_Type; Player : in Player_Type) return Boolean
    with Pre => Get_Piece_At((Move.Start.X, Move.Start.Y)) = (Pawn, PLayer);
    function is_valid_rook(dx : in Integer; dy : in Integer; Move : in Move_Type) return Boolean
    with Pre => Get_Piece_At((Move.Start.X, Move.Start.Y)).Piece = Rook;
    function is_valid_knight(dx : in Integer; dy : in Integer) return Boolean;
    function is_valid_bishop(dx : in Integer; dy : in Integer; Start : in Coordinate) return Boolean;
    function is_valid_queen(dx : in Integer; dy : in Integer; Move : in Move_Type) return Boolean
    with Pre => Get_Piece_At((Move.Start.X, Move.Start.Y)).Piece = Queen;
    function is_valid_king(dx : in Integer; dy : in Integer) return Boolean;
    function valid_piece_move(Move : in Move_Type; Player : in Player_Type) return Boolean;
    function is_valid_move(Move : in Move_Type; Player : in Player_Type) return Boolean
    with Pre => Is_Valid_Board,
         Post => Is_Valid_Board;
    function is_valid_castling(Side : in Side_Type; Player : in Player_Type) return Boolean
    with Pre => Is_Valid_Board,
         Post => Is_Valid_Board
         and White_Castling_Q'Old = White_Castling_Q
         and White_Castling_K'Old = White_Castling_K
         and Black_Castling_Q'Old = Black_Castling_Q
         and Black_Castling_K'Old = Black_Castling_K;
end Move;
