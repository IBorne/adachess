with Ada.Text_IO; use Ada.Text_IO;
package Chess is
    size : constant := 12;
    subtype game_size is Integer range 1 .. size;
    type Cell is (empty, forbidden,
                  pawn_white, rook_white, knight_white, bishop_white, queen_white, king_white,
                  pawn_black, rook_black, knight_black, bishop_black, queen_black, king_black);
    subtype white_range is Natural range 3 .. 8;
    subtype black_range is Natural range 9 .. 14;

    type Player is (White, Black);

    type Board is array (game_size,game_size) of Cell;

    game_board : Board;

    function is_valid_move(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer; p : in Player) return Boolean;
    procedure init_gameboard;
    procedure move_piece(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer);
    procedure print_gameboard;
private

end Chess;
