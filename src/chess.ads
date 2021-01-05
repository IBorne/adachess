with Ada.Text_IO; use Ada.Text_IO;
package Chess is
    size : constant := 12;
    subtype game_size is Integer range 1 .. size;
    type Cell is (Empty, Forbidden,
                  Pawn_white, Rook_white, Knight_white, Bishop_white, Queen_white, King_white,
                  Pawn_black, Rook_black, Knight_black, Bishop_black, Queen_black, King_black);
    subtype white_range is Natural range 2 .. 7;
    subtype black_range is Natural range 8 .. 13;

    type Player is (White, Black);

    type Board is array (game_size,game_size) of Cell;

    game_board : Board;

    procedure init_gameboard;
    function get_piece_at(x : in Integer; y : in Integer; p : in Player) return Cell;
    procedure move_piece(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer; p : in Player);
    procedure print_gameboard;
private

end Chess;
