with Chess; use Chess;

package Move is
    function get_player(c : in Cell) return Player;
    function is_valid_pawn(delta_x : in Integer; delta_y : in Integer; x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer; p : in Player; prev : in String) return Boolean;
    function is_valid_rook(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer; p : in Player) return Boolean;
    function is_valid_knight(delta_x : in Integer; delta_y : in Integer) return Boolean;
    function is_valid_bishop(delta_x : in Integer; delta_y : in Integer; x_start : in Integer; y_start : in Integer; p : in Player) return Boolean;
    function is_valid_queen(delta_x : in Integer; delta_y : in Integer; x_start : in Integer; y_start : in Integer; p : in Player) return Boolean;
    function is_valid_king(delta_x : in Integer; delta_y : in Integer) return Boolean;
    function valid_piece_move(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer; p : in Player; prev : in String) return Boolean;
    function is_valid_move(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer; p : in Player; prev : in String) return Boolean;
end Move;
