with Chess; use Chess;

package Move is
    function is_valid_pawn(dx : in Integer; dy : in Integer; Move : in Move_Type; Player : in Player_Type) return Boolean;
    function is_valid_rook(dx : in Integer; dy : in Integer; Move : in Move_Type) return Boolean;
    function is_valid_knight(dx : in Integer; dy : in Integer) return Boolean;
    function is_valid_bishop(dx : in Integer; dy : in Integer; Start : in Coordinate) return Boolean;
    function is_valid_queen(dx : in Integer; dy : in Integer; Move : in Move_Type) return Boolean;
    function is_valid_king(dx : in Integer; dy : in Integer) return Boolean;
    function valid_piece_move(Move : in Move_Type; Player : in Player_Type) return Boolean;
    function is_valid_move(Move : in Move_Type; Player : in Player_Type) return Boolean;
    function is_valid_castling(Side : in Side_Type; Player : in Player_Type) return Boolean;
end Move;
