with Ada.Text_IO; use Ada.Text_IO;
package Chess is
    size : constant := 12;
    subtype game_size is Integer range 1 .. size;
    type Cell is (Empty, Forbidden,
                  Pawn_white, Rook_white, Knight_white, Bishop_white, Queen_white, King_white,
                  Pawn_black, Rook_black, Knight_black, Bishop_black, Queen_black, King_black);
    subtype white_range is Natural range 3 .. 8;
    subtype black_range is Natural range 9 .. 14;

    type Player is (White, Black);
    side    : Player := White;

    type Board is array (game_size,game_size) of Cell;
    game_board : Board;

    function is_valid_move(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer;  prev : in String) return Boolean;
    procedure init_gameboard;
    function get_piece_at(x : in Integer; y : in Integer) return Cell;
    procedure move_piece(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer);
    procedure print_gameboard;
private

end Chess;
