with Chess; use Chess;

package Move is
    function is_valid_pawn(dx : In Integer; dy : In Integer; Move : In Move_Type; p : In Player_Type) return Boolean;
    function is_valid_rook(Move : In Move_Type) return Boolean;
    function is_valid_knight(dx : In Integer; dy : In Integer) return Boolean;
    function is_valid_bishop(dx : In Integer; dy : In Integer; Start : In Coordinate) return Boolean;
    function is_valid_queen(dx : In Integer; dy : In Integer; Move : In Move_Type) return Boolean;
    function is_valid_king(dx : In Integer; dy : In Integer) return Boolean;
    function valid_piece_move(Move : In Move_Type; p : In Player_Type) return Boolean;
    function is_valid_move(Move : In Move_Type; p : In Player_Type) return Boolean;
end Move;
